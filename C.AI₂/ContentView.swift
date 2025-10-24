//
//  ContentView.swift
//  C.AI₂
//
//  Created by Aidan Quach on 10/24/25.
//

import SwiftUI
import AVFoundation
import PhotosUI
import MapKit
import CoreLocation
import Combine

struct ContentView: View {
    @State private var showOnboarding = true
    @State private var hasCompletedOnboarding = false
    
    var body: some View {
        if hasCompletedOnboarding {
            MainTabView()
        } else {
            OnboardingFlow(hasCompletedOnboarding: $hasCompletedOnboarding)
        }
    }
}

// MARK: - Onboarding Flow
struct OnboardingFlow: View {
    @Binding var hasCompletedOnboarding: Bool
    @State private var currentPage = 0
    
    var body: some View {
        TabView(selection: $currentPage) {
            SplashScreen()
                .tag(0)
            
            FeatureShowcase1()
                .tag(1)
            
            FeatureShowcase2()
                .tag(2)
            
            SignInScreen(hasCompletedOnboarding: $hasCompletedOnboarding)
                .tag(3)
        }
        .tabViewStyle(.page(indexDisplayMode: .never))
        .ignoresSafeArea()
    }
}

// MARK: - Splash Screen
struct SplashScreen: View {
    @State private var animate = false
    
    var body: some View {
        ZStack {
            Color.white
                .ignoresSafeArea()
            
            VStack(spacing: 0) {
                Spacer()
                
                // Placeholder logo - easily replaceable
                ZStack {
                    Circle()
                        .fill(Color.black)
                        .frame(width: 120, height: 120)
                    
                    Text("🌱")
                        .font(.system(size: 60))
                }
                .scaleEffect(animate ? 1.0 : 0.8)
                .opacity(animate ? 1.0 : 0.8)
                
                Text("C.AI₂")
                    .font(.system(size: 48, weight: .bold, design: .default))
                    .foregroundColor(.black)
                    .padding(.top, 24)
                
                Spacer()
                
                Text("curated by")
                    .font(.system(size: 14, weight: .regular))
                    .foregroundColor(.gray)
                
                Text("Your Team")
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(.black)
                    .padding(.top, 4)
                    .padding(.bottom, 50)
            }
        }
        .onAppear {
            withAnimation(.easeOut(duration: 0.6)) {
                animate = true
            }
        }
    }
}

// MARK: - Feature Showcase 1
struct FeatureShowcase1: View {
    var body: some View {
        ZStack {
            Color.white
                .ignoresSafeArea()
            
            VStack(spacing: 0) {
                Spacer()
                
                // Mock phone with camera interface
                ZStack {
                    RoundedRectangle(cornerRadius: 40)
                        .fill(Color.black)
                        .frame(width: 280, height: 560)
                    
                    RoundedRectangle(cornerRadius: 35)
                        .fill(Color(.systemGray5))
                        .frame(width: 270, height: 550)
                        .overlay(
        VStack {
                                HStack {
                                    Circle()
                                        .fill(Color.white)
                                        .frame(width: 8, height: 8)
                                    
                                    Capsule()
                                        .fill(Color.white)
                                        .frame(width: 60, height: 8)
                                }
                                .padding(.top, 20)
                                
                                Spacer()
                                
                                // Camera viewfinder
                                RoundedRectangle(cornerRadius: 20)
                                    .strokeBorder(Color.white, lineWidth: 3)
                                    .frame(width: 200, height: 200)
                                
                                Spacer()
                                
                                // Camera button
                                Circle()
                                    .stroke(Color.white, lineWidth: 4)
                                    .frame(width: 70, height: 70)
                                    .overlay(
                                        Circle()
                                            .fill(Color.white)
                                            .frame(width: 58, height: 58)
                                    )
                                    .padding(.bottom, 40)
                            }
                        )
                }
                
                Spacer()
                    .frame(height: 60)
                
                Text("Carbon tracking")
                    .font(.system(size: 34, weight: .bold))
                    .foregroundColor(.black)
                
                Text("made easy")
                    .font(.system(size: 34, weight: .bold))
                    .foregroundColor(.black)
                    .padding(.top, 4)
                
                Spacer()
                    .frame(height: 100)
            }
        }
    }
}

// MARK: - Feature Showcase 2
struct FeatureShowcase2: View {
    var body: some View {
        ZStack {
            Color.white
                .ignoresSafeArea()
            
            VStack(spacing: 0) {
                HStack {
                    Spacer()
                }
                
                Spacer()
                    .frame(height: 100)
                
                Text("Track your")
                    .font(.system(size: 38, weight: .bold))
                    .foregroundColor(.black)
                
                Text("daily footprint")
                    .font(.system(size: 38, weight: .bold))
                    .foregroundColor(.black)
                    .padding(.top, 4)
                
                Spacer()
                    .frame(height: 60)
                
                // CO2 Display Card
                VStack(spacing: 16) {
                    HStack {
                        Image(systemName: "leaf.fill")
                            .font(.system(size: 32))
                            .foregroundColor(.green)
                        
                        Spacer()
                    }
                    .padding(.horizontal, 24)
                    .padding(.top, 24)
                    
                    HStack {
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Today's CO₂")
                                .font(.system(size: 16, weight: .regular))
                                .foregroundColor(.gray)
                            
                            HStack(alignment: .firstTextBaseline, spacing: 4) {
                                Text("2.4")
                                    .font(.system(size: 56, weight: .bold))
                                    .foregroundColor(.black)
                                
                                Text("kg")
                                    .font(.system(size: 24, weight: .semibold))
                                    .foregroundColor(.gray)
                            }
                        }
                        
                        Spacer()
                    }
                    .padding(.horizontal, 24)
                    .padding(.bottom, 24)
                }
                .background(Color(.systemGray6))
                .cornerRadius(24)
                .frame(maxWidth: 320)
                
                Spacer()
                
                Text("Snap photos, track miles,")
                    .font(.system(size: 16, weight: .regular))
                    .foregroundColor(.gray)
                
                Text("reduce your impact")
                    .font(.system(size: 16, weight: .regular))
                    .foregroundColor(.gray)
                    .padding(.top, 4)
                    .padding(.bottom, 80)
            }
            .padding(.horizontal, 24)
        }
    }
}

// MARK: - Sign In Screen
struct SignInScreen: View {
    @Binding var hasCompletedOnboarding: Bool
    
    var body: some View {
        ZStack {
            Color.white
                .ignoresSafeArea()
            
            VStack(spacing: 0) {
                Spacer()
                
                // Logo
                ZStack {
                    Circle()
                        .fill(Color.black)
                        .frame(width: 100, height: 100)
                    
                    Text("🌱")
                        .font(.system(size: 50))
                }
                
                Text("C.AI₂")
                    .font(.system(size: 42, weight: .bold))
                    .foregroundColor(.black)
                    .padding(.top, 20)
                
                Spacer()
                
                VStack(spacing: 12) {
                    // Apple Sign In Button
                    Button(action: {
                        // Placeholder action
                        hasCompletedOnboarding = true
                    }) {
                        HStack(spacing: 12) {
                            Image(systemName: "apple.logo")
                                .font(.system(size: 20, weight: .semibold))
                            
                            Text("Continue with Apple")
                                .font(.system(size: 17, weight: .semibold))
                        }
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: 56)
                        .background(Color.black)
                        .cornerRadius(16)
                    }
                    
                    // Google Sign In Button
                    Button(action: {
                        // Placeholder action
                        hasCompletedOnboarding = true
                    }) {
                        HStack(spacing: 12) {
            Image(systemName: "globe")
                                .font(.system(size: 20, weight: .semibold))
                            
                            Text("Continue with Google")
                                .font(.system(size: 17, weight: .semibold))
                        }
                        .foregroundColor(.black)
                        .frame(maxWidth: .infinity)
                        .frame(height: 56)
                        .background(Color(.systemGray6))
                        .cornerRadius(16)
                    }
                    
                    // Email Sign In Button
                    Button(action: {
                        // Placeholder action
                        hasCompletedOnboarding = true
                    }) {
                        HStack(spacing: 12) {
                            Image(systemName: "envelope.fill")
                                .font(.system(size: 20, weight: .semibold))
                            
                            Text("Continue with Email")
                                .font(.system(size: 17, weight: .semibold))
                        }
                        .foregroundColor(.black)
                        .frame(maxWidth: .infinity)
                        .frame(height: 56)
                        .background(Color(.systemGray6))
                        .cornerRadius(16)
                    }
                }
                .padding(.horizontal, 32)
                
                Button(action: {
                    // Placeholder action
                    hasCompletedOnboarding = true
                }) {
                    Text("Already have an account? Sign In")
                        .font(.system(size: 15, weight: .regular))
                        .foregroundColor(.gray)
                }
                .padding(.top, 32)
                .padding(.bottom, 50)
            }
        }
    }
}

// MARK: - Main Tab View
struct MainTabView: View {
    var body: some View {
        TabView {
            HomeScreen()
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Home")
                }
            
            SettingsScreen()
                .tabItem {
                    Image(systemName: "gearshape.fill")
                    Text("Settings")
                }
        }
        .accentColor(.black)
    }
}

// MARK: - Home Screen
struct HomeScreen: View {
    @State private var showCamera = false
    @StateObject private var locationManager = LocationManager()
    @State private var showMap = false
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.white
                    .ignoresSafeArea()
                
                VStack(spacing: 0) {
                    // Header
                    HStack {
                        Text("Today")
                            .font(.system(size: 34, weight: .bold))
                            .foregroundColor(.black)
                        
                        Spacer()
                        
                        Button(action: {
                            // Settings action
                        }) {
                            Image(systemName: "gearshape.fill")
                                .font(.system(size: 20))
                                .foregroundColor(.gray)
                        }
                    }
                    .padding(.horizontal, 24)
                    .padding(.top, 20)
                    .padding(.bottom, 24)
                    
                    // Carbon Footprint Section Header
                    HStack {
                        Text("Carbon Footprint")
                            .font(.system(size: 20, weight: .bold))
                            .foregroundColor(.black)
                        
                        Spacer()
                    }
                    .padding(.horizontal, 24)
                    .padding(.bottom, 20)
                    
                    // CO2 Card
                    VStack(spacing: 20) {
                        HStack {
                            Image(systemName: "leaf.fill")
                                .font(.system(size: 28))
                                .foregroundColor(.green)
                            
                            Spacer()
                            
                            Text("Oct 24")
                                .font(.system(size: 15, weight: .medium))
                                .foregroundColor(.gray)
                        }
                        
                        HStack {
                            VStack(alignment: .leading, spacing: 8) {
                                Text("Carbon Footprint")
                                    .font(.system(size: 17, weight: .regular))
                                    .foregroundColor(.gray)
                                
                                HStack(alignment: .firstTextBaseline, spacing: 6) {
                                    Text("0.0")
                                        .font(.system(size: 64, weight: .bold))
                                        .foregroundColor(.white)
                                    
                                    Text("kg CO₂e")
                                        .font(.system(size: 20, weight: .semibold))
                                        .foregroundColor(.gray)
                                }
                            }
                            
                            Spacer()
                        }
                    }
                    .padding(24)
                    .background(Color.black)
                    .cornerRadius(24)
                    .padding(.horizontal, 24)
                    
                    Spacer()
                        .frame(height: 20)
                    
                    // Camera Button
                    Button(action: {
                        showCamera = true
                    }) {
                        HStack(spacing: 12) {
                            Image(systemName: "camera.fill")
                                .font(.system(size: 22, weight: .semibold))
                            
                            Text("Scan Item")
                                .font(.system(size: 18, weight: .semibold))
                        }
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: 60)
                        .background(Color.black)
                        .cornerRadius(20)
                    }
                    .padding(.horizontal, 24)
                    
                    Spacer()
                        .frame(height: 20)
                    
                    // Driving Activity Card - Cal.AI Style
                    VStack(spacing: 0) {
                        // Header
                        HStack {
                            Text("Driving Activity")
                                .font(.system(size: 20, weight: .bold))
                                .foregroundColor(.black)
                            
                            Spacer()
                            
                            Button(action: {
                                showMap = true
                            }) {
                                HStack(spacing: 4) {
                                    Text("View Map")
                                        .font(.system(size: 16, weight: .medium))
                                        .foregroundColor(.green)
                                    
                                    Image(systemName: "chevron.right")
                                        .font(.system(size: 14, weight: .semibold))
                                        .foregroundColor(.green)
                                }
                            }
                        }
                        .padding(.horizontal, 24)
                        .padding(.bottom, 20)
                        
                        // Content Card
                        VStack(spacing: 20) {
                            if locationManager.isTracking {
                                // Active tracking state
                                HStack {
                                    VStack(alignment: .leading, spacing: 8) {
                                        HStack(spacing: 8) {
                                            Circle()
                                                .fill(Color.green)
                                                .frame(width: 8, height: 8)
                                            
                                            Text("Tracking Route")
                                                .font(.system(size: 16, weight: .medium))
                                                .foregroundColor(.black)
                                        }
                                        
                                        HStack(spacing: 24) {
                                            VStack(alignment: .leading, spacing: 4) {
                                                Text("Distance")
                                                    .font(.system(size: 14, weight: .regular))
                                                    .foregroundColor(.gray)
                                                
                                                Text(String(format: "%.1f km", locationManager.totalDistance / 1000))
                                                    .font(.system(size: 28, weight: .bold))
                                                    .foregroundColor(.black)
                                            }
                                            
                                            VStack(alignment: .leading, spacing: 4) {
                                                Text("CO₂ Emissions")
                                                    .font(.system(size: 14, weight: .regular))
                                                    .foregroundColor(.gray)
                                                
                                                Text(String(format: "%.1f kg", locationManager.estimatedCO2))
                                                    .font(.system(size: 28, weight: .bold))
                                                    .foregroundColor(.green)
                                            }
                                            
                                            Spacer()
                                        }
                                    }
                                    
                                    Spacer()
                                }
                                
                                // Stop button
                                Button(action: {
                                    locationManager.stopTracking()
                                }) {
                                    Text("Stop Tracking")
                                        .font(.system(size: 17, weight: .semibold))
                                        .foregroundColor(.white)
                                        .frame(maxWidth: .infinity)
                                        .frame(height: 56)
                                        .background(Color.red)
                                        .cornerRadius(16)
                                }
                            } else {
                                // Inactive state
                                VStack(spacing: 20) {
                                    HStack {
                                        Image(systemName: "car.fill")
                                            .font(.system(size: 24))
                                            .foregroundColor(.green)
                                        
                                        Spacer()
                                        
                                        Text("0.0 km")
                                            .font(.system(size: 24, weight: .bold))
                                            .foregroundColor(.black)
                                    }
                                    
                                    Text("Start driving to track your route and carbon emissions")
                                        .font(.system(size: 16, weight: .regular))
                                        .foregroundColor(.gray)
                                        .multilineTextAlignment(.center)
                                    
                                    Button(action: {
                                        locationManager.startTracking()
                                    }) {
                                        Text("Start Tracking")
                                            .font(.system(size: 17, weight: .semibold))
                                            .foregroundColor(.white)
                                            .frame(maxWidth: .infinity)
                                            .frame(height: 56)
                                            .background(Color.green)
                                            .cornerRadius(16)
                                    }
                                }
                            }
                        }
                        .padding(24)
                        .background(Color.white)
                        .cornerRadius(20)
                        .overlay(
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(Color(.systemGray5), lineWidth: 1)
                        )
                        .padding(.horizontal, 24)
                        .padding(.bottom, 24)
                    }
                    
                    Spacer()
                }
            }
            .navigationBarHidden(true)
        }
        .sheet(isPresented: $showCamera) {
            CameraView(isPresented: $showCamera)
        }
        .sheet(isPresented: $showMap) {
            MapView(locationManager: locationManager, isPresented: $showMap)
        }
    }
}

// MARK: - Settings Screen
struct SettingsScreen: View {
    var body: some View {
        NavigationView {
            ZStack {
                Color.white
                    .ignoresSafeArea()
                
                VStack(spacing: 0) {
                    // Header
                    HStack {
                        Text("Settings")
                            .font(.system(size: 34, weight: .bold))
                            .foregroundColor(.black)
                        
                        Spacer()
                    }
                    .padding(.horizontal, 24)
                    .padding(.top, 60)
                    .padding(.bottom, 32)
                    
                    // Settings placeholder
                    VStack(spacing: 16) {
                        SettingsRow(icon: "person.fill", title: "Account", showChevron: true)
                        SettingsRow(icon: "bell.fill", title: "Notifications", showChevron: true)
                        SettingsRow(icon: "chart.bar.fill", title: "Statistics", showChevron: true)
                        SettingsRow(icon: "questionmark.circle.fill", title: "Help & Support", showChevron: true)
                    }
                    .padding(.horizontal, 24)
                    
                    Spacer()
                }
            }
            .navigationBarHidden(true)
        }
    }
}

// MARK: - Settings Row
struct SettingsRow: View {
    let icon: String
    let title: String
    let showChevron: Bool
    
    var body: some View {
        Button(action: {
            // Placeholder action
        }) {
            HStack(spacing: 16) {
                Image(systemName: icon)
                    .font(.system(size: 20))
                    .foregroundColor(.black)
                    .frame(width: 24)
                
                Text(title)
                    .font(.system(size: 17, weight: .regular))
                    .foregroundColor(.black)
                
                Spacer()
                
                if showChevron {
                    Image(systemName: "chevron.right")
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundColor(.gray)
                }
            }
            .padding(20)
            .background(Color(.systemGray6))
            .cornerRadius(16)
        }
    }
}

// MARK: - Camera View
struct CameraView: View {
    @Binding var isPresented: Bool
    @State private var showImagePicker = false
    @State private var capturedImage: UIImage?
    @State private var showCameraPicker = false
    @State private var showPermissionAlert = false
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.black
                    .ignoresSafeArea()
                
                VStack {
                    HStack {
                        Button(action: {
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
                        
                        Button(action: {
                            // Flash toggle
                        }) {
                            Image(systemName: "bolt.fill")
                                .font(.system(size: 20, weight: .semibold))
                                .foregroundColor(.white)
                                .frame(width: 44, height: 44)
                                .background(Color.white.opacity(0.2))
                                .clipShape(Circle())
                        }
                    }
                    .padding(.horizontal, 24)
                    .padding(.top, 60)
                    
                    Spacer()
                    
                    // Viewfinder
                    RoundedRectangle(cornerRadius: 24)
                        .strokeBorder(Color.white, lineWidth: 3)
                        .frame(width: 280, height: 280)
                    
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
                            // Check camera availability
                            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                                showCameraPicker = true
                            } else {
                                showPermissionAlert = true
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
                            // Switch camera
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
        .sheet(isPresented: $showCameraPicker) {
            ImagePicker(image: $capturedImage, sourceType: .camera)
        }
        .sheet(item: Binding<CapturedImage?>(
            get: { capturedImage.map(CapturedImage.init) },
            set: { _ in capturedImage = nil }
        )) { image in
            ImageReviewView(image: image.image, isPresented: $isPresented)
        }
        .alert("Camera Access Required", isPresented: $showPermissionAlert) {
            Button("Settings") {
                if let settingsUrl = URL(string: UIApplication.openSettingsURLString) {
                    UIApplication.shared.open(settingsUrl)
                }
            }
            Button("Cancel", role: .cancel) { }
        } message: {
            Text("Please allow camera access in Settings to scan items for carbon footprint tracking.")
        }
    }
}

// MARK: - Image Picker
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

// MARK: - Captured Image Model
struct CapturedImage: Identifiable {
    let id = UUID()
    let image: UIImage
}

// MARK: - Image Review View
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
                    
                    Text("Analyzing carbon footprint...")
                        .font(.system(size: 16))
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.center)
                }
                
                Spacer()
                
                Button(action: {
                    showAnalysis = true
                }) {
                    Text("Analyze Carbon Impact")
                        .font(.system(size: 17, weight: .semibold))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: 56)
                        .background(Color.black)
                        .cornerRadius(16)
                }
                .padding(.horizontal, 24)
                .padding(.bottom, 32)
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

// MARK: - Carbon Analysis View
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
                        
                        Text("Analyzing carbon footprint...")
                            .font(.system(size: 18, weight: .medium))
                            .foregroundColor(.gray)
                        
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
                        
                        // Additional info card
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
                            // Retake photo
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
            // Simulate analysis delay
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                // Mock analysis results - randomize for demo
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

// MARK: - Location Manager
class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    private let locationManager = CLLocationManager()
    @Published var isTracking: Bool = false
    @Published var totalDistance: Double = 0.0
    @Published var estimatedCO2: Double = 0.0
    @Published var currentLocation: CLLocation?
    @Published var routeCoordinates: [CLLocationCoordinate2D] = []
    
    private var lastLocation: CLLocation?
    private var startLocation: CLLocation?
    
    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = 10 // Update every 10 meters
    }
    
    func startTracking() {
        guard locationManager.authorizationStatus == .authorizedWhenInUse || 
              locationManager.authorizationStatus == .authorizedAlways else {
            locationManager.requestWhenInUseAuthorization()
            return
        }
        
        isTracking = true
        routeCoordinates.removeAll()
        totalDistance = 0.0
        estimatedCO2 = 0.0
        lastLocation = nil
        startLocation = nil
        
        locationManager.startUpdatingLocation()
    }
    
    func stopTracking() {
        isTracking = false
        locationManager.stopUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last, isTracking else { return }
        
        currentLocation = location
        
        if startLocation == nil {
            startLocation = location
        }
        
        if let lastLocation = lastLocation {
            let distance = location.distance(from: lastLocation)
            totalDistance += distance
            
            // Estimate CO2 emissions (average car: ~120g CO2 per km)
            let co2PerKm = 0.12 // kg CO2 per km
            estimatedCO2 = (totalDistance / 1000) * co2PerKm
        }
        
        lastLocation = location
        routeCoordinates.append(location.coordinate)
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .authorizedWhenInUse, .authorizedAlways:
            if isTracking {
                locationManager.startUpdatingLocation()
            }
        case .denied, .restricted:
            isTracking = false
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        @unknown default:
            break
        }
    }
}

// MARK: - Map View
struct MapView: View {
    @ObservedObject var locationManager: LocationManager
    @Binding var isPresented: Bool
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4194),
        span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
    )
    
    var body: some View {
        NavigationView {
            ZStack {
                Map(coordinateRegion: $region)
                    .overlay(
                        // Route points overlay
                        MapPointsOverlay(coordinates: locationManager.routeCoordinates)
                    )
                
                VStack {
                    Spacer()
                    
                    // Bottom stats card
                    VStack(spacing: 16) {
                        HStack {
                            VStack(alignment: .leading, spacing: 4) {
                                Text("Distance")
                                    .font(.system(size: 14, weight: .regular))
                                    .foregroundColor(.gray)
                                
                                Text(String(format: "%.1f km", locationManager.totalDistance / 1000))
                                    .font(.system(size: 28, weight: .bold))
                                    .foregroundColor(.black)
                            }
                            
                            Spacer()
                            
                            VStack(alignment: .trailing, spacing: 4) {
                                Text("CO₂ Emissions")
                                    .font(.system(size: 14, weight: .regular))
                                    .foregroundColor(.gray)
                                
                                Text(String(format: "%.1f kg", locationManager.estimatedCO2))
                                    .font(.system(size: 28, weight: .bold))
                                    .foregroundColor(.green)
                            }
                        }
                        
                        HStack(spacing: 12) {
                            if locationManager.isTracking {
                                Button(action: {
                                    locationManager.stopTracking()
                                }) {
                                    Text("Stop Tracking")
                                        .font(.system(size: 16, weight: .semibold))
                                        .foregroundColor(.white)
                                        .frame(maxWidth: .infinity)
                                        .frame(height: 50)
                                        .background(Color.red)
                                        .cornerRadius(16)
                                }
                            } else {
                                Button(action: {
                                    locationManager.startTracking()
                                }) {
                                    Text("Start Tracking")
                                        .font(.system(size: 16, weight: .semibold))
                                        .foregroundColor(.white)
                                        .frame(maxWidth: .infinity)
                                        .frame(height: 50)
                                        .background(Color.green)
                                        .cornerRadius(16)
                                }
                            }
                            
                            Button(action: {
                                // Reset tracking
                                locationManager.stopTracking()
                                locationManager.totalDistance = 0.0
                                locationManager.estimatedCO2 = 0.0
                                locationManager.routeCoordinates.removeAll()
                            }) {
                                Text("Reset")
                                    .font(.system(size: 16, weight: .semibold))
                                    .foregroundColor(.black)
                                    .frame(maxWidth: .infinity)
                                    .frame(height: 50)
                                    .background(Color(.systemGray6))
                                    .cornerRadius(16)
                            }
                        }
                    }
                    .padding(24)
                    .background(Color.white)
                    .cornerRadius(24)
                    .padding(.horizontal, 24)
                    .padding(.bottom, 50)
                }
            }
            .navigationTitle("Route Tracking")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(
                leading: Button("Done") {
                    isPresented = false
                }
            )
        }
        .onAppear {
            if let location = locationManager.currentLocation {
                region.center = location.coordinate
            }
        }
        .onReceive(locationManager.$currentLocation) { location in
            if let location = location {
                region.center = location.coordinate
            }
        }
    }
}

// MARK: - Map Points Overlay
struct MapPointsOverlay: View {
    let coordinates: [CLLocationCoordinate2D]

    var body: some View {
        GeometryReader { geometry in
            ForEach(coordinates.indices, id: \.self) { index in
                let point = convertCoordinateToPoint(coordinates[index], in: geometry.size)
                Circle()
                    .fill(Color.green)
                    .frame(width: 8, height: 8)
                    .position(point)
            }

            // Route line
            if coordinates.count > 1 {
                Path { path in
                    let startPoint = convertCoordinateToPoint(coordinates[0], in: geometry.size)
                    path.move(to: startPoint)

                    for coordinate in coordinates.dropFirst() {
                        let point = convertCoordinateToPoint(coordinate, in: geometry.size)
                        path.addLine(to: point)
                    }
                }
                .stroke(Color.green, lineWidth: 3)
            }
        }
    }

    private func convertCoordinateToPoint(_ coordinate: CLLocationCoordinate2D, in size: CGSize) -> CGPoint {
        // Simplified coordinate conversion for demo
        let x = (coordinate.longitude + 180) / 360 * Double(size.width)
        let y = (90 - coordinate.latitude) / 180 * Double(size.height)
        return CGPoint(x: x, y: y)
    }
}

#Preview {
    ContentView()
}
