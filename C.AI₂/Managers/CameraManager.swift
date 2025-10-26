//
//  CameraManager.swift
//  C.AI₂
//
//  Created by Aidan Quach on 10/24/25.
//

import AVFoundation
import UIKit
import Combine

// MARK: - Camera Manager
class CameraManager: NSObject, ObservableObject {
    private var captureSession: AVCaptureSession?
    private var capturePhotoOutput: AVCapturePhotoOutput?
    private var videoPreviewLayer: AVCaptureVideoPreviewLayer?
    private var captureDevice: AVCaptureDevice?
    private var currentCameraPosition: AVCaptureDevice.Position = .back
    
    var onImageCaptured: ((UIImage) -> Void)?
    private weak var cameraPreviewLayer: AVCaptureVideoPreviewLayer?
    private var cropRect: CGRect?
    
    override init() {
        super.init()
        setupCamera()
    }
    
    func setupCamera() {
        captureSession = AVCaptureSession()
        captureSession?.sessionPreset = .photo
        
        guard let defaultCaptureDevice = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: currentCameraPosition) else {
            print("Camera not available")
            return
        }
        
        captureDevice = defaultCaptureDevice
        
        do {
            let input = try AVCaptureDeviceInput(device: defaultCaptureDevice)
            
            if captureSession?.canAddInput(input) ?? false {
                captureSession?.addInput(input)
            }
            
            capturePhotoOutput = AVCapturePhotoOutput()
            if let output = capturePhotoOutput, captureSession?.canAddOutput(output) ?? false {
                captureSession?.addOutput(output)
            }
            
            captureSession?.startRunning()
        } catch {
            print("Error setting up camera: \(error)")
        }
    }
    
    func createPreviewLayer(for view: UIView) {
        guard let session = captureSession else { return }
        
        let previewLayer = AVCaptureVideoPreviewLayer(session: session)
        previewLayer.videoGravity = .resizeAspectFill
        previewLayer.frame = view.bounds
        view.layer.insertSublayer(previewLayer, at: 0)
        
        cameraPreviewLayer = previewLayer
    }
    
    func updatePreviewLayerFrame(_ frame: CGRect) {
        cameraPreviewLayer?.frame = frame
    }
    
    func capturePhoto(completion: @escaping (UIImage) -> Void) {
        onImageCaptured = completion
        
        guard let photoOutput = capturePhotoOutput,
              let session = captureSession,
              session.isRunning else {
            print("Camera not ready")
            return
        }
        
        let settings: AVCapturePhotoSettings
        if photoOutput.availablePhotoCodecTypes.contains(.hevc) {
            settings = AVCapturePhotoSettings(format: [AVVideoCodecKey: AVVideoCodecType.hevc])
        } else {
            settings = AVCapturePhotoSettings()
        }
        
        photoOutput.capturePhoto(with: settings, delegate: self)
    }
    
    func capturePhotoWithCrop(cropRect: CGRect, completion: @escaping (UIImage) -> Void) {
        onImageCaptured = completion
        self.cropRect = cropRect
        
        guard let photoOutput = capturePhotoOutput,
              let session = captureSession,
              session.isRunning else {
            print("Camera not ready")
            return
        }
        
        let settings: AVCapturePhotoSettings
        if photoOutput.availablePhotoCodecTypes.contains(.hevc) {
            settings = AVCapturePhotoSettings(format: [AVVideoCodecKey: AVVideoCodecType.hevc])
        } else {
            settings = AVCapturePhotoSettings()
        }
        
        photoOutput.capturePhoto(with: settings, delegate: self)
    }
    
    func switchCamera() {
        guard let session = captureSession else { return }
        
        session.beginConfiguration()
        
        // Remove all inputs
        for input in session.inputs {
            session.removeInput(input)
        }
        
        // Switch position
        currentCameraPosition = currentCameraPosition == .back ? .front : .back
        
        // Add new input
        guard let newDevice = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: currentCameraPosition),
              let newInput = try? AVCaptureDeviceInput(device: newDevice) else {
            session.commitConfiguration()
            return
        }
        
        captureDevice = newDevice
        
        if session.canAddInput(newInput) {
            session.addInput(newInput)
        }
        
        session.commitConfiguration()
    }
    
    func stopSession() {
        captureSession?.stopRunning()
    }
}

extension CameraManager: AVCapturePhotoCaptureDelegate {
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        guard let imageData = photo.fileDataRepresentation(),
              let image = UIImage(data: imageData) else { return }
        
        DispatchQueue.main.async {
            if let cropRect = self.cropRect {
                // Crop the image to the specified rectangle
                let croppedImage = self.cropImage(image, toRect: cropRect)
                self.onImageCaptured?(croppedImage)
            } else {
                self.onImageCaptured?(image)
            }
        }
    }
    
    private func cropImage(_ image: UIImage, toRect cropRect: CGRect) -> UIImage {
        guard let cgImage = image.cgImage else { return image }
        
        // Get the actual image dimensions
        let imageSize = CGSize(width: cgImage.width, height: cgImage.height)
        
        // Get the preview layer size (this represents the screen coordinates)
        let previewSize = cameraPreviewLayer?.bounds.size ?? UIScreen.main.bounds.size
        
        // Calculate the aspect ratio of the image vs preview
        let imageAspectRatio = imageSize.width / imageSize.height
        let previewAspectRatio = previewSize.width / previewSize.height
        
        // Determine how the image is fitted in the preview (aspect fit)
        let scaleX: CGFloat
        let scaleY: CGFloat
        let offsetX: CGFloat
        let offsetY: CGFloat
        
        if imageAspectRatio > previewAspectRatio {
            // Image is wider than preview - letterboxed vertically
            scaleX = imageSize.width / previewSize.width
            scaleY = scaleX
            offsetX = 0
            offsetY = (imageSize.height - previewSize.height * scaleY) / 2
        } else {
            // Image is taller than preview - letterboxed horizontally
            scaleY = imageSize.height / previewSize.height
            scaleX = scaleY
            offsetX = (imageSize.width - previewSize.width * scaleX) / 2
            offsetY = 0
        }
        
        // Convert crop rectangle from screen coordinates to image coordinates
        let imageCropRect = CGRect(
            x: cropRect.origin.x * scaleX + offsetX,
            y: cropRect.origin.y * scaleY + offsetY,
            width: cropRect.width * scaleX,
            height: cropRect.height * scaleY
        )
        
        // Ensure the crop rect is within image bounds and is square
        let maxSize = min(imageCropRect.width, imageCropRect.height)
        let squareSize = min(maxSize, min(imageSize.width, imageSize.height))
        
        let clampedRect = CGRect(
            x: max(0, min(imageCropRect.origin.x, imageSize.width - squareSize)),
            y: max(0, min(imageCropRect.origin.y, imageSize.height - squareSize)),
            width: squareSize,
            height: squareSize
        )
        
        // Crop the image
        guard let croppedCGImage = cgImage.cropping(to: clampedRect) else { return image }
        
        return UIImage(cgImage: croppedCGImage, scale: image.scale, orientation: image.imageOrientation)
    }
}

