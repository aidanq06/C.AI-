//
//  CameraService.swift
//  C.AI₂
//
//  Camera capture and image handling
//

import SwiftUI
import AVFoundation
import Photos

@MainActor
class CameraService: ObservableObject {
    @Published var capturedImage: UIImage?
    @Published var isAuthorized = false
    @Published var showingCamera = false
    
    func requestPermission() {
        AVCaptureDevice.requestAccess(for: .video) { [weak self] granted in
            Task { @MainActor in
                self?.isAuthorized = granted
            }
        }
    }
    
    func checkAuthorization() {
        let status = AVCaptureDevice.authorizationStatus(for: .video)
        isAuthorized = status == .authorized
    }
    
    func openCamera() {
        guard isAuthorized else {
            requestPermission()
            return
        }
        showingCamera = true
    }
    
    func saveImage(_ image: UIImage) {
        capturedImage = image
    }
    
    func clearImage() {
        capturedImage = nil
    }
}

// MARK: - Image Picker Coordinator

struct ImagePicker: UIViewControllerRepresentable {
    @Binding var image: UIImage?
    @Environment(\.dismiss) var dismiss
    let sourceType: UIImagePickerController.SourceType
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.sourceType = sourceType
        picker.delegate = context.coordinator
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        let parent: ImagePicker
        
        init(_ parent: ImagePicker) {
            self.parent = parent
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let image = info[.originalImage] as? UIImage {
                parent.image = image
            }
            parent.dismiss()
        }
        
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            parent.dismiss()
        }
    }
}

