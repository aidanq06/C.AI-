//
//  CameraViews.swift
//  C.AI₂
//
//  Created by Aidan Quach on 10/24/25.
//

import SwiftUI
import AVFoundation
import PhotosUI

struct CameraView: View {
    @Binding var isPresented: Bool
    @State private var capturedImage: UIImage?
    @State private var showImagePicker = false
    @StateObject private var cameraManager = CameraManager()
    @State private var viewfinderFrame: CGRect = .zero
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.black
                    .ignoresSafeArea()
                
                // Live camera preview
                LiveCameraPreview(cameraManager: cameraManager)
                    .ignoresSafeArea()
                
                VStack {
                    HStack {
                        Button(action: {
                            cameraManager.stopSession()
                            isPresented = false
                        }) {
                            Image(systemName: "xmark")
                                .font(.system(size: 20, weight: .semibold))
                                .foregroundColor(.white)
                                .frame(width: 44, height: 44)
                                .background(Color.white.opacity(0.2))
                                .clipShape(Circle())
                        }
                        
                        Spacer()
                    }
                    .padding(.horizontal, 24)
                    .padding(.top, 60)
                    
                    Spacer()
                    
                    // Viewfinder
                    RoundedRectangle(cornerRadius: 24)
                        .strokeBorder(Color.white, lineWidth: 3)
                        .frame(width: 280, height: 280)
                        .allowsHitTesting(false)
                    
                    Text("Point camera at item")
                        .font(.system(size: 17, weight: .medium))
                        .foregroundColor(.white)
                        .padding(.top, 32)
                    
                    Spacer()
                    
                    HStack(spacing: 40) {
                        // Gallery button
                        Button(action: {
                            showImagePicker = true
                        }) {
                            Image(systemName: "photo.on.rectangle")
                                .font(.system(size: 24))
                                .foregroundColor(.white)
                                .frame(width: 60, height: 60)
                                .background(Color.white.opacity(0.2))
                                .clipShape(Circle())
                        }
                        
                        // Capture button
                        Button(action: {
                            let screenBounds = UIScreen.main.bounds
                            let centerX = screenBounds.width / 2
                            let centerY = screenBounds.height / 2
                            let squareSize: CGFloat = 240
                            let rightOffset: CGFloat = 15
                            let cropRect = CGRect(
                                x: centerX - (squareSize / 2) + rightOffset,
                                y: centerY - (squareSize / 2),
                                width: squareSize,
                                height: squareSize
                            )
                            
                            cameraManager.capturePhotoWithCrop(cropRect: cropRect) { image in
                                capturedImage = image
                            }
                        }) {
                            Circle()
                                .stroke(Color.white, lineWidth: 5)
                                .frame(width: 80, height: 80)
                                .overlay(
                                    Circle()
                                        .fill(Color.white)
                                        .frame(width: 66, height: 66)
                                )
                        }
                        
                        // Switch camera button
                        Button(action: {
                            cameraManager.switchCamera()
                        }) {
                            Image(systemName: "camera.rotate")
                                .font(.system(size: 24))
                                .foregroundColor(.white)
                                .frame(width: 60, height: 60)
                                .background(Color.white.opacity(0.2))
                                .clipShape(Circle())
                        }
                    }
                    .padding(.bottom, 50)
                }
            }
            .navigationBarHidden(true)
        }
        .sheet(isPresented: $showImagePicker) {
            ImagePicker(image: $capturedImage, sourceType: .photoLibrary)
        }
        .sheet(item: Binding<CapturedImage?>(
            get: { capturedImage.map(CapturedImage.init) },
            set: { _ in capturedImage = nil }
        )) { image in
            ImageReviewView(image: image.image, isPresented: $isPresented)
        }
        .onDisappear {
            cameraManager.stopSession()
        }
    }
}

struct LiveCameraPreview: UIViewRepresentable {
    @ObservedObject var cameraManager: CameraManager
    
    func makeUIView(context: Context) -> UIView {
        let view = UIView()
        view.backgroundColor = .black
        cameraManager.createPreviewLayer(for: view)
        return view
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
        DispatchQueue.main.async {
            self.cameraManager.updatePreviewLayerFrame(uiView.bounds)
        }
    }
}

struct ImagePicker: UIViewControllerRepresentable {
    @Binding var image: UIImage?
    @Environment(\.presentationMode) var presentationMode
    let sourceType: UIImagePickerController.SourceType
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        picker.sourceType = sourceType
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
            parent.presentationMode.wrappedValue.dismiss()
        }
        
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            parent.presentationMode.wrappedValue.dismiss()
        }
    }
}

struct ImageReviewView: View {
    let image: UIImage
    @Binding var isPresented: Bool
    @State private var showAnalysis = false
    
    var body: some View {
        NavigationView {
            VStack(spacing: 24) {
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .cornerRadius(16)
                    .padding(.horizontal, 24)
                
                VStack(spacing: 16) {
                    Text("Item Captured")
                        .font(.system(size: 24, weight: .bold))
                        .foregroundColor(.black)
                }
                
                Spacer()
                
                Button(action: {
                    showAnalysis = true
                }) {
                    Text("Analyze Carbon Impact")
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: 64)
                        .background(Color.black)
                        .cornerRadius(20)
                }
                .padding(.horizontal, 24)
                .padding(.bottom, 40)
            }
            .navigationTitle("Review")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(
                leading: Button("Cancel") {
                    isPresented = false
                },
                trailing: Button("Retake") {
                    // Retake photo
                }
            )
        }
        .sheet(isPresented: $showAnalysis) {
            CarbonAnalysisView(image: image, isPresented: $isPresented)
        }
    }
}

struct CarbonAnalysisView: View {
    let image: UIImage
    @Binding var isPresented: Bool
    @State private var carbonFootprint: Double = 0.0
    @State private var itemName = "Unknown Item"
    @State private var isAnalyzing = true
    @State private var showAddToTotal = false
    
    var body: some View {
        NavigationView {
            VStack(spacing: 24) {
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 200)
                    .cornerRadius(16)
                    .padding(.horizontal, 24)
                
                if isAnalyzing {
                    VStack(spacing: 16) {
                        ProgressView()
                            .scaleEffect(1.5)
                            .tint(.green)
                        
                        Text("Using AI to identify item and calculate environmental impact")
                            .font(.system(size: 14, weight: .regular))
                            .foregroundColor(.gray)
                            .multilineTextAlignment(.center)
                    }
                } else {
                    VStack(spacing: 20) {
                        Text(itemName)
                            .font(.system(size: 24, weight: .bold))
                            .foregroundColor(.black)
                        
                        HStack(alignment: .firstTextBaseline, spacing: 6) {
                            Text(String(format: "%.1f", carbonFootprint))
                                .font(.system(size: 48, weight: .bold))
                                .foregroundColor(.green)
                            
                            Text("kg CO₂e")
                                .font(.system(size: 18, weight: .semibold))
                                .foregroundColor(.gray)
                        }
                        
                        Text("Estimated carbon footprint")
                            .font(.system(size: 16))
                            .foregroundColor(.gray)
                        
                        VStack(spacing: 12) {
                            HStack {
                                Image(systemName: "info.circle.fill")
                                    .font(.system(size: 16))
                                    .foregroundColor(.green)
                                
                                Text("Environmental Impact")
                                    .font(.system(size: 16, weight: .semibold))
                                    .foregroundColor(.black)
                                
                                Spacer()
                            }
                            
                            Text("This item contributes to your daily carbon footprint. Consider sustainable alternatives when possible.")
                                .font(.system(size: 14, weight: .regular))
                                .foregroundColor(.gray)
                                .multilineTextAlignment(.leading)
                        }
                        .padding(16)
                        .background(Color(.systemGray6))
                        .cornerRadius(12)
                        .padding(.horizontal, 24)
                    }
                }
                
                Spacer()
                
                if !isAnalyzing {
                    VStack(spacing: 12) {
                        Button(action: {
                            showAddToTotal = true
                        }) {
                            Text("Add to Daily Total")
                                .font(.system(size: 17, weight: .semibold))
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .frame(height: 56)
                                .background(Color.black)
                                .cornerRadius(16)
                        }
                        
                        Button(action: {
                            isPresented = false
                        }) {
                            Text("Retake Photo")
                                .font(.system(size: 17, weight: .medium))
                                .foregroundColor(.gray)
                        }
                    }
                    .padding(.horizontal, 24)
                }
            }
            .padding(.top, 24)
            .navigationTitle("Analysis")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(
                leading: Button("Cancel") {
                    isPresented = false
                }
            )
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                let items = [
                    ("Beef Steak", 2.4),
                    ("Chicken Breast", 0.8),
                    ("Salmon Fillet", 1.2),
                    ("Avocado", 0.3),
                    ("Banana", 0.1),
                    ("Coffee", 0.2),
                    ("Cheese", 1.1),
                    ("Eggs", 0.4)
                ]
                
                let randomItem = items.randomElement() ?? ("Unknown Item", 0.5)
                itemName = randomItem.0
                carbonFootprint = randomItem.1
                isAnalyzing = false
            }
        }
        .alert("Added to Daily Total", isPresented: $showAddToTotal) {
            Button("OK") {
                isPresented = false
            }
        } message: {
            Text("\(itemName) (\(String(format: "%.1f", carbonFootprint)) kg CO₂e) has been added to your daily carbon footprint.")
        }
    }
}

