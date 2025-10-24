//
//  CaptureView.swift
//  C.AI₂
//
//  Camera capture and AI analysis flow
//

import SwiftUI

struct CaptureView: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var carbonData: CarbonDataService
    @ObservedObject var aiService: AIService
    @ObservedObject var cameraService: CameraService
    @ObservedObject var locationService: LocationService
    
    @State private var showingImagePicker = false
    @State private var capturedImage: UIImage?
    @State private var analysisResult: (description: String, co2: Double, category: CarbonCategory)?
    @State private var isAnalyzing = false
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            
            if let image = capturedImage, let result = analysisResult {
                // Analysis result view
                resultView(image: image, result: result)
            } else if let image = capturedImage {
                // Analyzing view
                analyzingView(image: image)
            } else {
                // Initial capture view
                capturePromptView
            }
        }
        .sheet(isPresented: $showingImagePicker) {
            ImagePicker(image: $capturedImage, sourceType: .camera)
        }
        .onChange(of: capturedImage) { _, newImage in
            if let image = newImage {
                analyzeImage(image)
            }
        }
    }
    
    // MARK: - Views
    
    private var capturePromptView: some View {
        VStack(spacing: 40) {
            // Close button
            HStack {
                Button(action: { dismiss() }) {
                    Image(systemName: "xmark")
                        .font(.system(size: 18, weight: .light))
                        .foregroundColor(.white.opacity(0.6))
                }
                Spacer()
            }
            .padding(.horizontal, 24)
            .padding(.top, 20)
            
            Spacer()
            
            VStack(spacing: 16) {
                Image(systemName: "viewfinder")
                    .font(.system(size: 64, weight: .ultraLight))
                    .foregroundColor(.white.opacity(0.3))
                
                Text("CAPTURE AN OBJECT")
                    .font(.system(size: 14, weight: .light, design: .rounded))
                    .foregroundColor(.white.opacity(0.6))
                    .tracking(2)
                
                Text("Point your camera at any item\nto measure its carbon footprint")
                    .font(.system(size: 13, weight: .light, design: .rounded))
                    .foregroundColor(.white.opacity(0.4))
                    .multilineTextAlignment(.center)
                    .tracking(0.5)
                    .padding(.top, 8)
            }
            
            Spacer()
            
            // Capture button
            Button(action: {
                showingImagePicker = true
            }) {
                Circle()
                    .fill(Color.white)
                    .frame(width: 72, height: 72)
                    .overlay(
                        Image(systemName: "camera.fill")
                            .font(.system(size: 28, weight: .light))
                            .foregroundColor(.black)
                    )
            }
            .padding(.bottom, 60)
        }
    }
    
    private func analyzingView(image: UIImage) -> some View {
        VStack(spacing: 32) {
            Spacer()
            
            // Image preview
            Image(uiImage: image)
                .resizable()
                .scaledToFit()
                .frame(height: 200)
                .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                .overlay(
                    RoundedRectangle(cornerRadius: 12, style: .continuous)
                        .stroke(Color.white.opacity(0.1), lineWidth: 1)
                )
            
            // Loading indicator
            VStack(spacing: 16) {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: .white))
                    .scaleEffect(1.2)
                
                Text("ANALYZING")
                    .font(.system(size: 12, weight: .light, design: .rounded))
                    .foregroundColor(.white.opacity(0.6))
                    .tracking(2)
            }
            
            Spacer()
        }
        .padding(.horizontal, 40)
    }
    
    private func resultView(image: UIImage, result: (description: String, co2: Double, category: CarbonCategory)) -> some View {
        VStack(spacing: 0) {
            // Close button
            HStack {
                Button(action: { dismiss() }) {
                    Image(systemName: "xmark")
                        .font(.system(size: 18, weight: .light))
                        .foregroundColor(.white.opacity(0.6))
                }
                Spacer()
            }
            .padding(.horizontal, 24)
            .padding(.top, 20)
            .padding(.bottom, 32)
            
            Spacer()
            
            // Image preview
            Image(uiImage: image)
                .resizable()
                .scaledToFit()
                .frame(height: 220)
                .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                .overlay(
                    RoundedRectangle(cornerRadius: 16, style: .continuous)
                        .stroke(Color.white.opacity(0.1), lineWidth: 1)
                )
                .padding(.horizontal, 40)
            
            // Result card
            VStack(spacing: 24) {
                // Item name
                Text(result.description.uppercased())
                    .font(.system(size: 13, weight: .medium, design: .rounded))
                    .foregroundColor(.white.opacity(0.5))
                    .tracking(2)
                
                // CO2 amount
                VStack(spacing: 8) {
                    Text(String(format: "%.2f", result.co2))
                        .font(.system(size: 56, weight: .thin, design: .rounded))
                        .foregroundColor(colorForCO2(result.co2))
                    
                    Text("kg CO₂")
                        .font(.system(size: 14, weight: .light, design: .rounded))
                        .foregroundColor(.white.opacity(0.5))
                        .tracking(1.5)
                }
                
                // Category
                Text(result.category.displayName.uppercased())
                    .font(.system(size: 11, weight: .light, design: .rounded))
                    .foregroundColor(.white.opacity(0.4))
                    .tracking(1.5)
            }
            .padding(.vertical, 40)
            .padding(.horizontal, 32)
            .frame(maxWidth: .infinity)
            .background(
                RoundedRectangle(cornerRadius: 20, style: .continuous)
                    .fill(Color.white.opacity(0.03))
                    .overlay(
                        RoundedRectangle(cornerRadius: 20, style: .continuous)
                            .stroke(Color.white.opacity(0.08), lineWidth: 1)
                    )
            )
            .padding(.horizontal, 24)
            .padding(.top, 32)
            
            Spacer()
            
            // Add button
            Button(action: {
                saveEntry(image: image, result: result)
            }) {
                Text("ADD TO TODAY")
                    .font(.system(size: 13, weight: .medium, design: .rounded))
                    .tracking(1.5)
                    .foregroundColor(.black)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 18)
                    .background(
                        RoundedRectangle(cornerRadius: 14, style: .continuous)
                            .fill(Color.white)
                    )
            }
            .padding(.horizontal, 24)
            .padding(.bottom, 50)
        }
    }
    
    // MARK: - Helpers
    
    private func analyzeImage(_ image: UIImage) {
        isAnalyzing = true
        
        Task {
            if let result = await aiService.analyzeImage(image) {
                withAnimation(.spring(response: 0.6, dampingFraction: 0.8)) {
                    analysisResult = result
                }
            }
            isAnalyzing = false
        }
    }
    
    private func saveEntry(image: UIImage, result: (description: String, co2: Double, category: CarbonCategory)) {
        let imageData = image.jpegData(compressionQuality: 0.7)
        
        let location = locationService.currentLocation.map {
            LocationData(coordinate: $0.coordinate)
        }
        
        let entry = CarbonEntry(
            co2Amount: result.co2,
            category: result.category,
            location: location,
            imageData: imageData,
            aiDescription: result.description
        )
        
        carbonData.addEntry(entry)
        
        // Haptic feedback
        let impact = UINotificationFeedbackGenerator()
        impact.notificationOccurred(.success)
        
        dismiss()
    }
    
    private func colorForCO2(_ amount: Double) -> Color {
        if amount < 0.5 {
            return Color.green
        } else if amount < 2.0 {
            return Color.white
        } else {
            return Color.white.opacity(0.7)
        }
    }
}

