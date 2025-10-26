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
import UIKit

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
                
                // Your Logo
                Image("AppLogo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 200, height: 200)
                    .scaleEffect(animate ? 1.0 : 0.8)
                    .opacity(animate ? 1.0 : 0.8)
                
                Text("C.AI₂")
                    .font(.system(size: 44, weight: .bold, design: .default))
                    .foregroundColor(.black)
                    .padding(.top, 24)
                
                Spacer()
                
                // Swipe Instruction
                VStack(spacing: 12) {
                    Image(systemName: "arrow.right.circle.fill")
                        .font(.system(size: 32))
                        .foregroundColor(.black.opacity(0.6))
                        .symbolEffect(.bounce, value: animate)
                    
                    Text("Swipe to continue")
                        .font(.system(size: 14, weight: .medium))
                        .foregroundColor(.gray)
                }
                .padding(.bottom, 60)
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
                
                VStack(spacing: 16) {
                    Text("Carbon tracking")
                        .font(.system(size: 32, weight: .bold))
                        .foregroundColor(.black)
                    
                    Text("made easy")
                        .font(.system(size: 32, weight: .bold))
                        .foregroundColor(.black)
                }
                
                Spacer()
                    .frame(height: 40)
                
                // Swipe Indicator
                Image(systemName: "arrow.right.circle.fill")
                    .font(.system(size: 28))
                    .foregroundColor(.black.opacity(0.3))
                
                Text("Swipe to continue")
                    .font(.system(size: 12, weight: .medium))
                    .foregroundColor(.gray)
                
                Spacer()
                    .frame(height: 40)
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
                
                VStack(spacing: 8) {
                    Text("Track your")
                        .font(.system(size: 32, weight: .bold))
                        .foregroundColor(.black)
                    
                    Text("daily footprint")
                        .font(.system(size: 32, weight: .bold))
                        .foregroundColor(.black)
                }
                
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
                
                VStack(spacing: 12) {
                    VStack(spacing: 4) {
                        Text("Snap photos, track miles,")
                            .font(.system(size: 14, weight: .regular))
                            .foregroundColor(.gray)
                        
                        Text("reduce your impact")
                            .font(.system(size: 14, weight: .regular))
                            .foregroundColor(.gray)
                    }
                    
                    // Swipe Indicator
                    Image(systemName: "arrow.right.circle.fill")
                        .font(.system(size: 28))
                        .foregroundColor(.black.opacity(0.3))
                    
                    Text("Swipe to continue")
                        .font(.system(size: 12, weight: .medium))
                        .foregroundColor(.gray)
                }
                .padding(.bottom, 60)
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
                Image("AppLogo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 150, height: 150)
                
                Text("C.AI₂")
                    .font(.system(size: 38, weight: .bold))
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
                    Text("Get started")
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(.black)
                        .padding(.top, 32)
                        .padding(.bottom, 12)
                        
                        // Swipe Indicator
                        Image(systemName: "hand.tap.fill")
                            .font(.system(size: 24))
                            .foregroundColor(.black.opacity(0.3))
                        
                        Text("Tap any button to continue")
                            .font(.system(size: 12, weight: .medium))
                            .foregroundColor(.gray)
                            .padding(.bottom, 32)
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
            
            DrivingScreen()
                .tabItem {
                    Image(systemName: "car.fill")
                    Text("Driving")
                }
            
            ScreenTimeScreen()
                .tabItem {
                    Image(systemName: "iphone")
                    Text("Screen Time")
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
    @State private var showCameraPermissionAlert = false
    @State private var cameraPermissionStatus: AVAuthorizationStatus = .notDetermined
    @State private var showCarbonLog = false
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.white
                    .ignoresSafeArea()
                
                VStack(spacing: 0) {
                    // Header
                    HStack {
                            Text("C.AI₂")
                            .font(.system(size: 34, weight: .bold))
                            .foregroundColor(.black)
                        
                        Spacer()
                            
                            // Help Button
                            Button(action: {
                                // Help action
                            }) {
                                Image(systemName: "questionmark.circle")
                                    .font(.system(size: 20, weight: .regular))
                                    .foregroundColor(.gray)
                            }
                    }
                    .padding(.horizontal, 24)
                    .padding(.top, 20)
                    .padding(.bottom, 24)
                    
                        
                        // CO2 Card with White Extension
                        Button(action: {
                            showCarbonLog = true
                        }) {
                            VStack(spacing: 0) {
                                // Black Section
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
                                                Text("2.4")
                                        .font(.system(size: 64, weight: .bold))
                                        .foregroundColor(.white)
                                    
                                    Text("kg CO₂e")
                                        .font(.system(size: 20, weight: .semibold))
                                        .foregroundColor(.gray)
                                }
                            }
                            
                            Spacer()
                                        
                                        Image(systemName: "chevron.right")
                                            .font(.system(size: 16, weight: .semibold))
                                            .foregroundColor(.gray)
                        }
                    }
                    .padding(24)
                    .background(Color.black)
                                
                                // White Section with CO2 Visualization
                                VStack(spacing: 12) {
                                    HStack {
                                        Text("Daily Usage")
                                            .font(.system(size: 14, weight: .semibold))
                                            .foregroundColor(.black)
                                        
                                        Spacer()
                                        
                                        Text("2.4 / 5.0 kg")
                                            .font(.system(size: 12, weight: .medium))
                                            .foregroundColor(.gray)
                                    }
                                    
                                    // Horizontal Progress Bar
                                    VStack(spacing: 8) {
                                        // Progress Bar Background
                                        GeometryReader { geometry in
                                            let dailyUsage: Double = 2.4
                                            let dailyMax: Double = 5.0
                                            let usagePercentage = min(dailyUsage / dailyMax, 1.0)
                                            let isOverLimit = dailyUsage > dailyMax
                                            
                                            ZStack(alignment: .leading) {
                                                // Background
                                                RoundedRectangle(cornerRadius: 8)
                                                    .fill(Color.gray.opacity(0.1))
                                                    .frame(height: 12)
                                                
                                                // Progress Fill
                                                RoundedRectangle(cornerRadius: 8)
                                                    .fill(isOverLimit ? Color.red : Color.green)
                                                    .frame(width: geometry.size.width * usagePercentage, height: 12)
                                                    .animation(.easeInOut(duration: 0.8), value: dailyUsage)
                                            }
                                        }
                                        .frame(height: 12)
                                        
                                        // Status Text
                                        HStack {
                                            Text("48% of daily limit")
                                                .font(.system(size: 11, weight: .medium))
                                                .foregroundColor(.gray)
                                            
                                            Spacer()
                                            
                                            Text("Good")
                                                .font(.system(size: 11, weight: .semibold))
                                                .foregroundColor(.green)
                                        }
                                    }
                                }
                                .padding(16)
                                .background(Color.white)
                            }
                    .cornerRadius(24)
                            .overlay(
                                RoundedRectangle(cornerRadius: 24)
                                    .stroke(Color.black, lineWidth: 2)
                            )
                        }
                        .padding(.horizontal, 24)
                        
                        Spacer()
                            .frame(height: 20)
                        
                        // Square Widgets Row
                        HStack(spacing: 16) {
                            // Daily Average Widget
                            VStack(spacing: 10) {
                                VStack(alignment: .leading, spacing: 6) {
                                    Text("Daily Average")
                                        .font(.system(size: 15, weight: .regular))
                                        .foregroundColor(.gray)
                                    
                                    Text("1.8")
                                        .font(.system(size: 30, weight: .bold))
                                        .foregroundColor(.green)
                                    
                                    Text("kg CO₂e")
                                        .font(.system(size: 13, weight: .medium))
                                        .foregroundColor(.gray)
                                }
                                .frame(maxWidth: .infinity, alignment: .leading)
                                
                                Spacer()
                            }
                            .frame(maxWidth: .infinity)
                            .aspectRatio(1, contentMode: .fit)
                            .padding(16)
                            .background(Color.white)
                            .cornerRadius(20)
                            .overlay(
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(Color.black, lineWidth: 2)
                            )
                            
                            // Monthly Goal Widget
                            VStack(spacing: 10) {
                                VStack(alignment: .leading, spacing: 6) {
                                    Text("Monthly Goal")
                                        .font(.system(size: 15, weight: .regular))
                                        .foregroundColor(.gray)
                                    
                                    Text("75%")
                                        .font(.system(size: 30, weight: .bold))
                                        .foregroundColor(.green)
                                    
                                    Text("of 50kg")
                                        .font(.system(size: 13, weight: .medium))
                                        .foregroundColor(.gray)
                                }
                                .frame(maxWidth: .infinity, alignment: .leading)
                                
                                Spacer()
                            }
                            .frame(maxWidth: .infinity)
                            .aspectRatio(1, contentMode: .fit)
                            .padding(16)
                            .background(Color.white)
                            .cornerRadius(20)
                            .overlay(
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(Color.black, lineWidth: 2)
                            )
                        }
                    .padding(.horizontal, 24)
                    
                    Spacer()
                        .frame(height: 20)
                    
                    // Camera Button
                    Button(action: {
                            checkCameraPermissionAndOpen()
                    }) {
                        HStack(spacing: 12) {
                            Image(systemName: "camera.fill")
                                .font(.system(size: 22, weight: .semibold))
                            
                            Text("Scan Item")
                                .font(.system(size: 18, weight: .semibold))
                        }
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                            .frame(height: 80)
                        .background(Color.black)
                        .cornerRadius(20)
                    }
                    .padding(.horizontal, 24)
                    
                    Spacer()
                    }
                }
                .navigationBarHidden(true)
            }
            .sheet(isPresented: $showCamera) {
                CameraView(isPresented: $showCamera)
            }
            .sheet(isPresented: $showCarbonLog) {
                CarbonFootprintLogView(isPresented: $showCarbonLog)
            }
            .alert("Camera Access Required", isPresented: $showCameraPermissionAlert) {
                Button("Settings") {
                    openAppSettings()
                }
                Button("Cancel", role: .cancel) { }
            } message: {
                Text("C.AI₂ needs camera access to scan items. Please enable camera access in Settings.")
            }
            .onAppear {
                checkCameraPermissionStatus()
            }
        }
        
        private func checkCameraPermissionStatus() {
            cameraPermissionStatus = AVCaptureDevice.authorizationStatus(for: .video)
        }
        
        private func checkCameraPermissionAndOpen() {
            switch cameraPermissionStatus {
            case .authorized:
                showCamera = true
            case .notDetermined:
                AVCaptureDevice.requestAccess(for: .video) { granted in
                    DispatchQueue.main.async {
                        cameraPermissionStatus = granted ? .authorized : .denied
                        if granted {
                            showCamera = true
                        } else {
                            showCameraPermissionAlert = true
                        }
                    }
                }
            case .denied, .restricted:
                showCameraPermissionAlert = true
            @unknown default:
                showCameraPermissionAlert = true
            }
        }
        
        private func openAppSettings() {
            if let settingsUrl = URL(string: UIApplication.openSettingsURLString) {
                UIApplication.shared.open(settingsUrl)
            }
        }
    }

// MARK: - Carbon Footprint Log View
struct CarbonFootprintLogView: View {
    @Binding var isPresented: Bool
    @State private var carbonEntries: [CarbonEntry] = []
    @State private var showAIReductionTips = false
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.white
                    .ignoresSafeArea()
                
                ScrollView {
                    VStack(spacing: 0) {
                        // Header Summary
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
                                    Text("Total Carbon Footprint")
                                        .font(.system(size: 17, weight: .regular))
                                        .foregroundColor(.gray)
                                    
                                    HStack(alignment: .firstTextBaseline, spacing: 6) {
                                        Text("2.4")
                                            .font(.system(size: 48, weight: .bold))
                                            .foregroundColor(.white)
                                        
                                        Text("kg CO₂e")
                                            .font(.system(size: 18, weight: .semibold))
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
                        .padding(.top, 20)
                        .padding(.bottom, 24)
                        
                        // AI Reduction Suggestions Button
                            Button(action: {
                            showAIReductionTips = true
                        }) {
                            HStack(spacing: 16) {
                                VStack(alignment: .leading, spacing: 4) {
                                    Text("AI-Powered Reduction Tips")
                                        .font(.system(size: 16, weight: .semibold))
                                        .foregroundColor(.black)
                                    
                                    Text("Get intelligent suggestions to reduce your carbon footprint")
                                        .font(.system(size: 14, weight: .regular))
                                        .foregroundColor(.gray)
                                        .multilineTextAlignment(.leading)
                                }
                                
                                Spacer()
                                    
                                    Image(systemName: "chevron.right")
                                        .font(.system(size: 14, weight: .semibold))
                                    .foregroundColor(.gray)
                            }
                            .padding(20)
                            .background(Color.white)
                            .cornerRadius(20)
                            .overlay(
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(
                                        LinearGradient(
                                            colors: [Color.green.opacity(0.8), Color.green.opacity(0.4)],
                                            startPoint: .topLeading,
                                            endPoint: .bottomTrailing
                                        ),
                                        lineWidth: 2
                                    )
                            )
                        }
                        .padding(.horizontal, 24)
                        .padding(.bottom, 24)
                        
                        // Activity Log
                        VStack(spacing: 0) {
                            HStack {
                                Text("Activity Log")
                                    .font(.system(size: 20, weight: .bold))
                                    .foregroundColor(.black)
                                
                                Spacer()
                        }
                        .padding(.horizontal, 24)
                        .padding(.bottom, 20)
                        
                            LazyVStack(spacing: 12) {
                                ForEach(carbonEntries) { entry in
                                    CarbonEntryRow(entry: entry)
                                }
                            }
                            .padding(.horizontal, 24)
                        }
                        
                        Spacer()
                            .frame(height: 100)
                    }
                }
            }
            .navigationTitle("Carbon Log")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(
                leading: Button("Done") {
                    isPresented = false
                }
            )
        }
        .sheet(isPresented: $showAIReductionTips) {
            AIReductionTipsView(isPresented: $showAIReductionTips)
        }
        .onAppear {
            loadCarbonEntries()
        }
    }
    
    private func loadCarbonEntries() {
        // Demo data - beautiful, clean entries
        carbonEntries = [
            CarbonEntry(
                id: UUID(),
                title: "Beef Steak",
                subtitle: "Dinner • 8:30 PM",
                co2Amount: 2.4,
                icon: "fork.knife",
                iconColor: .red,
                timeAgo: "2 hours ago"
            ),
            CarbonEntry(
                id: UUID(),
                title: "Driving to Work",
                subtitle: "Commute • 8:15 AM",
                co2Amount: 1.2,
                icon: "car.fill",
                iconColor: .blue,
                timeAgo: "14 hours ago"
            ),
            CarbonEntry(
                id: UUID(),
                title: "Coffee",
                subtitle: "Morning • 7:45 AM",
                co2Amount: 0.2,
                icon: "cup.and.saucer.fill",
                iconColor: .brown,
                timeAgo: "15 hours ago"
            ),
            CarbonEntry(
                id: UUID(),
                title: "Screen Time",
                subtitle: "Digital Usage • All Day",
                co2Amount: 0.1,
                icon: "iphone",
                iconColor: .purple,
                timeAgo: "Ongoing"
            )
        ]
    }
}

// MARK: - AI Reduction Tips View
struct AIReductionTipsView: View {
    @Binding var isPresented: Bool
    @State private var suggestions: [AIReductionSuggestion] = []
    @State private var isAnalyzing = true
    @State private var showContent = false
    @State private var selectedCardId: UUID? = nil
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.white
                    .ignoresSafeArea()
                
                ScrollView {
                    VStack(spacing: 0) {
                        // Header
                        VStack(spacing: 16) {
                                HStack {
                                Text("AI Reduction Tips")
                                    .font(.system(size: 28, weight: .bold))
                                    .foregroundColor(.black)
                                    .opacity(showContent ? 1 : 0)
                                    .offset(y: showContent ? 0 : -20)
                                    .animation(.easeOut(duration: 0.6).delay(0.1), value: showContent)
                                
                                Spacer()
                            }
                            
                            Text("Intelligent suggestions tailored to your carbon footprint")
                                .font(.system(size: 16, weight: .regular))
                                .foregroundColor(.gray)
                                .multilineTextAlignment(.leading)
                                .opacity(showContent ? 1 : 0)
                                .offset(y: showContent ? 0 : -20)
                                .animation(.easeOut(duration: 0.6).delay(0.2), value: showContent)
                        }
                        .padding(.horizontal, 24)
                        .padding(.top, 20)
                        .padding(.bottom, 32)
                        
                        if isAnalyzing {
                            // Analysis Loading State
                            VStack(spacing: 24) {
                                ZStack {
                                            Circle()
                                        .stroke(Color.green.opacity(0.1), lineWidth: 2)
                                        .frame(width: 60, height: 60)
                                    
                                    Circle()
                                        .trim(from: 0, to: 0.3)
                                        .stroke(Color.green, lineWidth: 2)
                                        .frame(width: 60, height: 60)
                                        .rotationEffect(.degrees(showContent ? 360 : 0))
                                        .animation(.linear(duration: 1.5).repeatForever(autoreverses: false), value: showContent)
                                }
                                
                                VStack(spacing: 8) {
                                    Text("Analyzing your carbon footprint")
                                        .font(.system(size: 18, weight: .medium))
                                                .foregroundColor(.black)
                                    
                                    Text("Generating personalized reduction strategies")
                                        .font(.system(size: 14, weight: .regular))
                                        .foregroundColor(.gray)
                                        .multilineTextAlignment(.center)
                                }
                            }
                            .frame(maxWidth: .infinity)
                            .frame(height: 200)
                        } else {
                            // AI Suggestions
                            LazyVStack(spacing: 12) {
                                ForEach(Array(suggestions.enumerated()), id: \.element.id) { index, suggestion in
                                    AIReductionSuggestionCard(
                                        suggestion: suggestion,
                                        selectedCardId: $selectedCardId
                                    )
                                        .opacity(showContent ? 1 : 0)
                                        .offset(y: showContent ? 0 : 20)
                                        .animation(
                                            .easeOut(duration: 0.5)
                                            .delay(Double(index) * 0.1 + 0.3),
                                            value: showContent
                                        )
                                }
                            }
                            .padding(.horizontal, 24)
                        }
                        
                        Spacer()
                            .frame(height: 100)
                    }
                }
            }
            .navigationTitle("Reduction Tips")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(
                leading: Button("Done") {
                    withAnimation(.easeInOut(duration: 0.3)) {
                        isPresented = false
                    }
                }
            )
        }
        .onAppear {
            showContent = true
            generateAISuggestions()
        }
    }
    
    private func generateAISuggestions() {
        // Simulate AI analysis delay
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
            suggestions = [
                AIReductionSuggestion(
                    id: UUID(),
                    title: "Optimize Your Commute",
                    impact: "Save 1.2 kg CO₂e",
                    description: "Your daily drive contributes 60% of your footprint. Consider the bus + 10-minute walk alternative.",
                    reasoning: "Same travel time, 70% less emissions. The bus route runs parallel to your driving route.",
                    difficulty: "Easy",
                    timeToImplement: "5 minutes",
                    category: "Transportation"
                ),
                AIReductionSuggestion(
                    id: UUID(),
                    title: "Smart Meal Planning",
                    impact: "Save 0.8 kg CO₂e",
                    description: "Replace 2 meat meals this week with plant-based alternatives.",
                    reasoning: "Your beef consumption is 3x the average. Plant proteins have 90% lower carbon intensity.",
                    difficulty: "Medium",
                    timeToImplement: "2 hours",
                    category: "Food"
                ),
                AIReductionSuggestion(
                    id: UUID(),
                    title: "Batch Your Errands",
                    impact: "Save 0.4 kg CO₂e",
                    description: "Combine grocery shopping with other trips to reduce driving frequency.",
                    reasoning: "You make 4 separate trips weekly. Batching reduces this to 2 trips, cutting emissions by 50%.",
                    difficulty: "Easy",
                    timeToImplement: "10 minutes",
                    category: "Transportation"
                ),
                AIReductionSuggestion(
                    id: UUID(),
                    title: "Digital Efficiency",
                    impact: "Save 0.1 kg CO₂e",
                    description: "Switch to dark mode and reduce screen brightness during evening hours.",
                    reasoning: "Your evening screen time uses 40% more energy. Dark mode reduces OLED power consumption by 60%.",
                    difficulty: "Easy",
                    timeToImplement: "1 minute",
                    category: "Digital"
                )
            ]
            
            withAnimation(.easeOut(duration: 0.4)) {
                isAnalyzing = false
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                withAnimation(.easeOut(duration: 0.6)) {
                    showContent = true
                }
            }
        }
    }
}

// MARK: - AI Reduction Suggestion Model
struct AIReductionSuggestion: Identifiable {
    let id: UUID
    let title: String
    let impact: String
    let description: String
    let reasoning: String
    let difficulty: String
    let timeToImplement: String
    let category: String
}

// MARK: - AI Reduction Suggestion Card
struct AIReductionSuggestionCard: View {
    let suggestion: AIReductionSuggestion
    @Binding var selectedCardId: UUID?
    @State private var isPressed = false
    
    private var isSelected: Bool {
        selectedCardId == suggestion.id
    }
    
    var body: some View {
        VStack(spacing: 16) {
            // Header
            HStack {
                                            VStack(alignment: .leading, spacing: 4) {
                    Text(suggestion.title)
                        .font(.system(size: 18, weight: .bold))
                        .foregroundColor(.black)
                    
                    Text(suggestion.impact)
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(.green)
                }
                
                Spacer()
                
                // Category Badge
                Text(suggestion.category)
                    .font(.system(size: 12, weight: .medium))
                    .foregroundColor(.gray)
                    .padding(.horizontal, 12)
                    .padding(.vertical, 6)
                    .background(Color(.systemGray6))
                    .cornerRadius(12)
            }
            
            // Description
            Text(suggestion.description)
                .font(.system(size: 15, weight: .regular))
                .foregroundColor(.black)
                .multilineTextAlignment(.leading)
                .lineSpacing(2)
            
            // Expandable Reasoning Section
            if isSelected {
                VStack(alignment: .leading, spacing: 8) {
                    Text("Why this works")
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundColor(.gray)
                    
                    Text(suggestion.reasoning)
                                                    .font(.system(size: 14, weight: .regular))
                                                    .foregroundColor(.gray)
                        .multilineTextAlignment(.leading)
                        .lineSpacing(2)
                }
                .padding(16)
                .background(Color(.systemGray6).opacity(0.5))
                .cornerRadius(12)
                .transition(.asymmetric(
                    insertion: .opacity.combined(with: .move(edge: .top)),
                    removal: .opacity.combined(with: .move(edge: .top))
                ))
            }
            
            // Implementation Details
            HStack(spacing: 20) {
                VStack(alignment: .leading, spacing: 2) {
                    Text("Difficulty")
                        .font(.system(size: 12, weight: .medium))
                        .foregroundColor(.gray)
                    
                    Text(suggestion.difficulty)
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundColor(difficultyColor)
                }
                
                Spacer()
                
                VStack(alignment: .trailing, spacing: 2) {
                    Text("Time")
                        .font(.system(size: 12, weight: .medium))
                        .foregroundColor(.gray)
                    
                    Text(suggestion.timeToImplement)
                        .font(.system(size: 14, weight: .semibold))
                                                    .foregroundColor(.black)
                }
            }
        }
        .padding(20)
        .background(Color.white)
        .cornerRadius(20)
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(
                    isSelected ? Color.green : Color(.systemGray5),
                    lineWidth: isSelected ? 2 : 1
                )
        )
        .scaleEffect(isPressed ? 0.98 : 1.0)
        .animation(.easeInOut(duration: 0.1), value: isPressed)
        .animation(.easeInOut(duration: 0.3), value: isSelected)
        .onTapGesture {
            withAnimation(.easeInOut(duration: 0.1)) {
                isPressed = true
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                withAnimation(.easeInOut(duration: 0.1)) {
                    isPressed = false
                }
            }
            
            // Toggle selection
            withAnimation(.easeInOut(duration: 0.3)) {
                if isSelected {
                    selectedCardId = nil
                } else {
                    selectedCardId = suggestion.id
                }
            }
        }
    }
    
    private var difficultyColor: Color {
        switch suggestion.difficulty {
        case "Easy": return .green
        case "Medium": return .orange
        case "Hard": return .red
        default: return .gray
        }
    }
}

// MARK: - Carbon Entry Model
struct CarbonEntry: Identifiable {
    let id: UUID
    let title: String
    let subtitle: String
    let co2Amount: Double
    let icon: String
    let iconColor: Color
    let timeAgo: String
}

// MARK: - Carbon Entry Row
struct CarbonEntryRow: View {
    let entry: CarbonEntry
    
    var body: some View {
        HStack(spacing: 16) {
            // Icon
            ZStack {
                Circle()
                    .fill(entry.iconColor.opacity(0.1))
                    .frame(width: 44, height: 44)
                
                Image(systemName: entry.icon)
                    .font(.system(size: 20, weight: .medium))
                    .foregroundColor(entry.iconColor)
            }
            
            // Content
                                            VStack(alignment: .leading, spacing: 4) {
                Text(entry.title)
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(.black)
                
                Text(entry.subtitle)
                                                    .font(.system(size: 14, weight: .regular))
                                                    .foregroundColor(.gray)
            }
            
            Spacer()
            
            // CO2 Amount
            VStack(alignment: .trailing, spacing: 2) {
                Text(String(format: "%.1f", entry.co2Amount))
                    .font(.system(size: 18, weight: .bold))
                                                    .foregroundColor(.green)
                
                Text("kg CO₂e")
                    .font(.system(size: 12, weight: .medium))
                    .foregroundColor(.gray)
            }
        }
        .padding(20)
        .background(Color.white)
        .cornerRadius(16)
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(Color(.systemGray5), lineWidth: 1)
        )
    }
}

// MARK: - Apple Maps Style Map Trail Component
struct MapTrailView: View {
    let routeID: Int
    
    var body: some View {
        ZStack {
            // Apple Maps style background
            Rectangle()
                .fill(Color(red: 0.95, green: 0.95, blue: 0.95))
                .cornerRadius(16)
            
            // Campus buildings and roads (Apple Maps style)
            VStack(spacing: 0) {
                // Campus area (green spaces)
                Rectangle()
                    .fill(Color(red: 0.7, green: 0.9, blue: 0.7))
                    .frame(height: 40)
                
                // Urban area
                Rectangle()
                    .fill(Color(red: 0.9, green: 0.9, blue: 0.9))
                    .frame(height: 60)
            }
            
            // Roads
            Path { path in
                // University Avenue
                path.move(to: CGPoint(x: -60, y: 20))
                path.addLine(to: CGPoint(x: 60, y: 20))
                
                // 13th Street
                path.move(to: CGPoint(x: -20, y: -20))
                path.addLine(to: CGPoint(x: -20, y: 60))
            }
            .stroke(Color.white, lineWidth: 3)
            
            // Route trail (purple like Apple Maps)
            Path { path in
                path.move(to: CGPoint(x: -50, y: 15))
                path.addQuadCurve(to: CGPoint(x: -15, y: 5), control: CGPoint(x: -32, y: 10))
                path.addQuadCurve(to: CGPoint(x: 20, y: 15), control: CGPoint(x: 2, y: 8))
                path.addQuadCurve(to: CGPoint(x: 50, y: 25), control: CGPoint(x: 35, y: 20))
            }
            .stroke(Color.purple, lineWidth: 4)
            
            // Apple Maps watermark
            VStack {
                Spacer()
                HStack {
                    Text("Maps")
                        .font(.system(size: 8, weight: .medium))
                        .foregroundColor(.gray)
                                            Spacer()
                }
                .padding(.horizontal, 8)
                .padding(.bottom, 4)
            }
        }
        .frame(height: 100)
        .cornerRadius(16)
    }
}

// MARK: - Driving Screen
struct DrivingScreen: View {
    @StateObject private var locationManager = LocationManager()
    @State private var showTripLog = false
    @State private var trips: [DetectedTrip] = []
    @State private var isTrackingEnabled = true
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.white
                    .ignoresSafeArea()
                
                VStack(spacing: 0) {
                    // Header
                    HStack {
                        Text("Driving")
                            .font(.system(size: 34, weight: .bold))
                            .foregroundColor(.black)
                                    
                                    Spacer()
                                }
                    .padding(.horizontal, 24)
                    .padding(.top, 20)
                    .padding(.bottom, 24)
                                
                    // Large Logs Card
                                Button(action: {
                        showTripLog = true
                    }) {
                        VStack(spacing: 0) {
                            // Black Header Section
                            VStack(spacing: 0) {
                                HStack {
                                    Text("Trip Logs")
                                        .font(.system(size: 20, weight: .bold))
                                        .foregroundColor(.white)
                                    
                                    Spacer()
                                    
                                    Text("View All")
                                        .font(.system(size: 14, weight: .medium))
                                        .foregroundColor(.white.opacity(0.7))
                                }
                                .padding(.horizontal, 24)
                                .padding(.top, 24)
                                .padding(.bottom, 20)
                            }
                            .background(Color.black)
                            
                            // White Content Section
                            VStack(spacing: 0) {
                                // Single Trip - Campus to Downtown
                                VStack(spacing: 8) {
                                    // Trip Header
                                    HStack {
                                        VStack(alignment: .leading, spacing: 1) {
                                            Text("UF Campus → Downtown")
                                                .font(.system(size: 15, weight: .semibold))
                                                .foregroundColor(.black)
                                            
                                            Text("08:30 - 08:54 • 24 min")
                                                .font(.system(size: 11, weight: .medium))
                                                .foregroundColor(.gray)
                                        }
                                        
                                        Spacer()
                                        
                                        VStack(alignment: .trailing, spacing: 1) {
                                            Text("1.2")
                                                .font(.system(size: 16, weight: .bold))
                                                .foregroundColor(.red)
                                            
                                            Text("kg CO₂")
                                                .font(.system(size: 9, weight: .medium))
                                                .foregroundColor(.gray)
                                        }
                                    }
                                    
                                    // Map Trail
                                    ZStack {
                                        MapTrailView(routeID: 1)
                                        
                                        // Start point (campus)
                                        Circle()
                                            .fill(Color.white)
                                            .frame(width: 8, height: 8)
                                            .overlay(
                                                Circle()
                                                    .stroke(Color.purple, lineWidth: 2)
                                            )
                                            .offset(x: -50, y: 15)
                                        
                                        // End point (downtown)
                                        Circle()
                                            .fill(Color.purple)
                                            .frame(width: 8, height: 8)
                                            .overlay(
                                                Circle()
                                                    .stroke(Color.white, lineWidth: 1)
                                            )
                                            .offset(x: 50, y: 25)
                                    }
                                    
                                    // Trip Stats
                                    HStack(spacing: 12) {
                                        VStack(spacing: 1) {
                                            Text("3.2")
                                                .font(.system(size: 13, weight: .bold))
                                                .foregroundColor(.black)
                                            
                                            Text("miles")
                                                .font(.system(size: 8, weight: .medium))
                                                .foregroundColor(.gray)
                                        }
                                        
                                        VStack(spacing: 1) {
                                            Text("35")
                                                .font(.system(size: 13, weight: .bold))
                                                .foregroundColor(.black)
                                            
                                            Text("mph max")
                                                .font(.system(size: 8, weight: .medium))
                                                .foregroundColor(.gray)
                                        }
                                        
                                        VStack(spacing: 1) {
                                            Text("28")
                                                .font(.system(size: 13, weight: .bold))
                                                .foregroundColor(.black)
                                            
                                            Text("avg mph")
                                                .font(.system(size: 8, weight: .medium))
                                                .foregroundColor(.gray)
                                        }
                                        
                                        Spacer()
                                    }
                                }
                                .padding(12)
                                .background(Color.white)
                                        .cornerRadius(16)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 16)
                                        .stroke(Color.gray.opacity(0.2), lineWidth: 1)
                                )
                            }
                            .padding(.top, 12)
                            .padding(.bottom, 16)
                            .background(Color.white)
                        }
                        .cornerRadius(24)
                        .overlay(
                            RoundedRectangle(cornerRadius: 24)
                                .stroke(Color.black, lineWidth: 2)
                        )
                    }
                    .padding(.horizontal, 24)
                    
                    Spacer()
                        .frame(height: 20)
                    
                    // Today Widget - Combined Black Widget
                                VStack(spacing: 20) {
                                    HStack {
                            Text("Today")
                                .font(.system(size: 18, weight: .bold))
                                .foregroundColor(.white)
                                        
                                        Spacer()
                        }
                        
                        HStack(spacing: 16) {
                            // Trips Count
                            VStack(spacing: 8) {
                                Text("1")
                                    .font(.system(size: 28, weight: .bold))
                                    .foregroundColor(.white)
                                
                                Text("Trip")
                                    .font(.system(size: 12, weight: .medium))
                                    .foregroundColor(.white.opacity(0.7))
                            }
                            .frame(maxWidth: .infinity)
                            
                            // Total Distance
                            VStack(spacing: 8) {
                                Text("3.2")
                                    .font(.system(size: 28, weight: .bold))
                                    .foregroundColor(.white)
                                
                                Text("miles")
                                    .font(.system(size: 12, weight: .medium))
                                    .foregroundColor(.white.opacity(0.7))
                            }
                            .frame(maxWidth: .infinity)
                            
                            // CO2 Emissions
                            VStack(spacing: 8) {
                                Text("1.2")
                                    .font(.system(size: 28, weight: .bold))
                                    .foregroundColor(.white)
                                
                                Text("kg CO₂")
                                    .font(.system(size: 12, weight: .medium))
                                    .foregroundColor(.white.opacity(0.7))
                            }
                            .frame(maxWidth: .infinity)
                        }
                    }
                    .padding(24)
                    .background(Color.black)
                    .cornerRadius(20)
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(Color.black, lineWidth: 2)
                    )
                    .padding(.horizontal, 24)
                    
                    Spacer()
                        .frame(height: 20)
                    
                    // Automatic Tracking Widget
                    VStack(spacing: 16) {
                        HStack {
                            Text("Automatic Tracking")
                                .font(.system(size: 18, weight: .bold))
                                .foregroundColor(.black)
                            
                            Spacer()
                            
                            Toggle("", isOn: $isTrackingEnabled)
                                .toggleStyle(SwitchToggleStyle(tint: .red))
                        }
                        
                        Text("Detects trips over 25 mph and logs them automatically")
                            .font(.system(size: 14, weight: .regular))
                            .foregroundColor(.gray)
                            .multilineTextAlignment(.leading)
                            .lineLimit(nil)
                            .fixedSize(horizontal: false, vertical: true)
                    }
                    .padding(24)
                    .background(Color.white)
                    .cornerRadius(20)
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(Color.black, lineWidth: 2)
                    )
                    .padding(.horizontal, 24)
                    
                    Spacer()
                }
            }
            .navigationBarHidden(true)
        }
        .sheet(isPresented: $showTripLog) {
            TripLogView(isPresented: $showTripLog)
        }
        .onAppear {
            loadDemoTrips()
        }
    }
    
    private func loadDemoTrips() {
        trips = [
            DetectedTrip(
                id: UUID(),
                date: Date(),
                startTime: "08:30",
                endTime: "08:54",
                distance: 8.5,
                maxSpeed: 45.0,
                averageSpeed: 32.0,
                transportMode: .unclassified,
                co2Emissions: 1.2
            ),
            DetectedTrip(
                id: UUID(),
                date: Calendar.current.date(byAdding: .hour, value: -3, to: Date()) ?? Date(),
                startTime: "12:15",
                endTime: "12:27",
                distance: 3.2,
                maxSpeed: 28.0,
                averageSpeed: 16.0,
                transportMode: .unclassified,
                co2Emissions: 0.0
            ),
            DetectedTrip(
                id: UUID(),
                date: Calendar.current.date(byAdding: .hour, value: -6, to: Date()) ?? Date(),
                startTime: "18:45",
                endTime: "19:03",
                distance: 5.8,
                maxSpeed: 52.0,
                averageSpeed: 29.0,
                transportMode: .unclassified,
                co2Emissions: 0.9
            )
        ]
    }
}

enum TransportMode: String, CaseIterable {
    case car = "Car"
    case bus = "Bus"
    case unclassified = "Unclassified"
}

struct DetectedTrip: Identifiable {
    let id: UUID
    let date: Date
    let startTime: String
    let endTime: String
    let distance: Double
    let maxSpeed: Double
    let averageSpeed: Double
    var transportMode: TransportMode
    let co2Emissions: Double
}

// MARK: - Trip Log View
struct TripLogView: View {
    @Binding var isPresented: Bool
    @State private var trips: [DetectedTrip] = []
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.white
                    .ignoresSafeArea()
                
                ScrollView {
                    VStack(spacing: 0) {
                        // Header
                        HStack {
                            Text("Trip Log")
                                .font(.system(size: 28, weight: .bold))
                                .foregroundColor(.black)
                            
                            Spacer()
                        }
                        .padding(.horizontal, 24)
                        .padding(.top, 20)
                        .padding(.bottom, 24)
                        
                        // Summary Stats
                        VStack(spacing: 16) {
                            HStack(spacing: 16) {
                                VStack(spacing: 8) {
                                    Text("3")
                                            .font(.system(size: 24, weight: .bold))
                                        .foregroundColor(.red)
                                    
                                    Text("Trips Today")
                                        .font(.system(size: 12, weight: .medium))
                                        .foregroundColor(.gray)
                                }
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 16)
                                .background(Color.gray.opacity(0.05))
                                .cornerRadius(12)
                                
                                VStack(spacing: 8) {
                                    Text("17.5")
                                        .font(.system(size: 24, weight: .bold))
                                        .foregroundColor(.red)
                                    
                                    Text("Total km")
                                        .font(.system(size: 12, weight: .medium))
                                        .foregroundColor(.gray)
                                }
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 16)
                                .background(Color.gray.opacity(0.05))
                                .cornerRadius(12)
                                
                                VStack(spacing: 8) {
                                    Text("2.1")
                                        .font(.system(size: 24, weight: .bold))
                                        .foregroundColor(.red)
                                    
                                    Text("kg CO₂")
                                        .font(.system(size: 12, weight: .medium))
                                        .foregroundColor(.gray)
                                }
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 16)
                                .background(Color.gray.opacity(0.05))
                                .cornerRadius(12)
                            }
                        }
                        .padding(.horizontal, 24)
                        .padding(.bottom, 24)
                        
                        // Trips List
                        LazyVStack(spacing: 12) {
                            ForEach(trips) { trip in
                                TripRow(trip: trip)
                            }
                        }
                        .padding(.horizontal, 24)
                        
                        Spacer()
                            .frame(height: 100)
                    }
                }
            }
            .navigationBarHidden(true)
        }
        .overlay(
            VStack {
                HStack {
                    Button("Done") {
                        isPresented = false
                    }
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(.red)
                    
                    Spacer()
                }
                .padding(.horizontal, 24)
                .padding(.top, 20)
                
                Spacer()
            }
        )
        .onAppear {
            loadDemoTrips()
        }
    }
    
    private func loadDemoTrips() {
        trips = [
            DetectedTrip(
                id: UUID(),
                date: Date(),
                startTime: "08:30",
                endTime: "08:54",
                distance: 8.5,
                maxSpeed: 45.0,
                averageSpeed: 32.0,
                transportMode: .unclassified,
                co2Emissions: 1.2
            ),
            DetectedTrip(
                id: UUID(),
                date: Calendar.current.date(byAdding: .hour, value: -3, to: Date()) ?? Date(),
                startTime: "12:15",
                endTime: "12:27",
                distance: 3.2,
                maxSpeed: 28.0,
                averageSpeed: 16.0,
                transportMode: .unclassified,
                co2Emissions: 0.0
            ),
            DetectedTrip(
                id: UUID(),
                date: Calendar.current.date(byAdding: .hour, value: -6, to: Date()) ?? Date(),
                startTime: "18:45",
                endTime: "19:03",
                distance: 5.8,
                maxSpeed: 52.0,
                averageSpeed: 29.0,
                transportMode: .unclassified,
                co2Emissions: 0.9
            )
        ]
    }
}

struct TripRow: View {
    @State var trip: DetectedTrip
    
    var body: some View {
        VStack(spacing: 16) {
            // Trip Header
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text("\(trip.startTime) - \(trip.endTime)")
                        .font(.system(size: 16, weight: .semibold))
                                            .foregroundColor(.black)
                    
                    Text(String(format: "%.1f km • Max: %.0f mph", trip.distance, trip.maxSpeed))
                        .font(.system(size: 12, weight: .medium))
                        .foregroundColor(.gray)
                }
                
                Spacer()
                
                VStack(alignment: .trailing, spacing: 4) {
                    Text(String(format: "%.1f", trip.co2Emissions))
                        .font(.system(size: 18, weight: .bold))
                        .foregroundColor(trip.co2Emissions > 0 ? .red : .green)
                    
                    Text("kg CO₂")
                        .font(.system(size: 10, weight: .medium))
                                        .foregroundColor(.gray)
                }
            }
                                    
            // Classification Buttons
            HStack(spacing: 12) {
                                    Button(action: {
                    trip.transportMode = .car
                }) {
                    Text("Car")
                        .font(.system(size: 14, weight: .medium))
                        .foregroundColor(trip.transportMode == .car ? .white : .gray)
                        .padding(.horizontal, 16)
                        .padding(.vertical, 8)
                        .background(trip.transportMode == .car ? Color.red : Color.gray.opacity(0.1))
                        .cornerRadius(8)
                }
                
                Button(action: {
                    trip.transportMode = .bus
                }) {
                    Text("Bus")
                        .font(.system(size: 14, weight: .medium))
                        .foregroundColor(trip.transportMode == .bus ? .white : .gray)
                        .padding(.horizontal, 16)
                        .padding(.vertical, 8)
                        .background(trip.transportMode == .bus ? Color.red : Color.gray.opacity(0.1))
                        .cornerRadius(8)
                }
                
                Spacer()
            }
        }
        .padding(20)
        .background(Color.white)
                                            .cornerRadius(16)
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(Color.gray.opacity(0.1), lineWidth: 1)
        )
    }
}

// MARK: - Screen Time Screen
struct ScreenTimeScreen: View {
    @State private var totalScreenTime: Double = 0.0
    @State private var estimatedCO2: Double = 0.0
    @State private var topApps: [(String, Double)] = []
    @State private var isAnalyzing = true
    @State private var showAppBreakdown = false
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.white
                    .ignoresSafeArea()
                
                ScrollView {
                    VStack(spacing: 0) {
                        // Header
                        HStack {
                            Text("Screen Time")
                                .font(.system(size: 34, weight: .bold))
                                .foregroundColor(.black)
                            
                            Spacer()
                        }
                        .padding(.horizontal, 24)
                        .padding(.top, 20)
                        .padding(.bottom, 24)
                        
                        if isAnalyzing {
                            // Analysis Loading State
                            VStack(spacing: 24) {
                                ProgressView()
                                    .scaleEffect(1.5)
                                    .tint(.blue)
                                
                                Text("Analyzing device usage...")
                                    .font(.system(size: 18, weight: .medium))
                                    .foregroundColor(.gray)
                                
                                Text("Calculating carbon footprint from app usage")
                                    .font(.system(size: 14, weight: .regular))
                                    .foregroundColor(.gray)
                                    .multilineTextAlignment(.center)
                            }
                            .frame(maxWidth: .infinity)
                            .frame(height: 200)
                        } else {
                            // Carbon Impact Card
                            VStack(spacing: 20) {
                                HStack {
                                    Image(systemName: "iphone")
                                        .font(.system(size: 28))
                                        .foregroundColor(.blue)
                                    
                                    Spacer()
                                    
                                    Text("Today")
                                        .font(.system(size: 15, weight: .medium))
                                        .foregroundColor(.gray)
                                }
                                
                                HStack {
                                    VStack(alignment: .leading, spacing: 8) {
                                        Text("Digital Carbon Footprint")
                                            .font(.system(size: 17, weight: .regular))
                                            .foregroundColor(.gray)
                                        
                                        HStack(alignment: .firstTextBaseline, spacing: 6) {
                                            Text(String(format: "%.2f", estimatedCO2))
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
                            .padding(.bottom, 24)
                            
                            // Usage Breakdown Card - Clickable
                            Button(action: {
                                showAppBreakdown = true
                            }) {
                                VStack(spacing: 24) {
                                    HStack {
                                        Text("Usage Breakdown")
                                            .font(.system(size: 20, weight: .bold))
                                            .foregroundColor(.black)
                                        
                                        Spacer()
                                        
                                        Text("View Details")
                                            .font(.system(size: 14, weight: .medium))
                                            .foregroundColor(.gray)
                                    }
                                    
                                    VStack(spacing: 20) {
                                        // Total Screen Time
                                        HStack {
                                            VStack(alignment: .leading, spacing: 6) {
                                                Text("Total Screen Time")
                                                    .font(.system(size: 16, weight: .medium))
                                                    .foregroundColor(.black)
                                                
                                                Text(String(format: "%.1f hours", totalScreenTime))
                                                    .font(.system(size: 28, weight: .bold))
                                                    .foregroundColor(.blue)
                                            }
                                            
                                            Spacer()
                                            
                                            Image(systemName: "clock.fill")
                                                .font(.system(size: 28))
                                                .foregroundColor(.blue)
                                        }
                                        
                                        Divider()
                                        
                                        // Top Apps Preview
                                        VStack(alignment: .leading, spacing: 16) {
                                            Text("Top Apps")
                                                .font(.system(size: 16, weight: .medium))
                                                .foregroundColor(.black)
                                            
                                            ForEach(topApps.prefix(3), id: \.0) { app in
                                                HStack {
                                                    Text(app.0)
                                                        .font(.system(size: 14, weight: .regular))
                                                        .foregroundColor(.gray)
                                                    
                                                    Spacer()
                                                    
                                                    Text(String(format: "%.1fh", app.1))
                                                        .font(.system(size: 14, weight: .medium))
                                                        .foregroundColor(.black)
                                                }
                                            }
                                        }
                                    }
                                }
                                .padding(28)
                        .background(Color.white)
                        .cornerRadius(20)
                        .overlay(
                            RoundedRectangle(cornerRadius: 20)
                                        .stroke(Color.black, lineWidth: 2)
                        )
                            }
                        .padding(.horizontal, 24)
                    }
                    
                    Spacer()
                            .frame(height: 100)
                    }
                }
            }
            .navigationBarHidden(true)
        }
        .sheet(isPresented: $showAppBreakdown) {
            AppCarbonBreakdownView(isPresented: $showAppBreakdown)
        }
        .onAppear {
            analyzeScreenTime()
        }
    }
    
    private func analyzeScreenTime() {
        // Simulate analysis delay
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            // Mock data - in real implementation, this would use Screen Time APIs
            totalScreenTime = Double.random(in: 4.0...8.0)
            estimatedCO2 = totalScreenTime * 0.05 // Rough estimate: 0.05 kg CO2 per hour
            topApps = [
                ("Safari", Double.random(in: 1.0...2.0)),
                ("Messages", Double.random(in: 0.5...1.5)),
                ("Instagram", Double.random(in: 0.5...1.0)),
                ("YouTube", Double.random(in: 0.3...0.8)),
                ("Mail", Double.random(in: 0.2...0.5))
            ].sorted { $0.1 > $1.1 }
            
            isAnalyzing = false
        }
    }
}

// MARK: - App Carbon Breakdown View
struct AppCarbonBreakdownView: View {
    @Binding var isPresented: Bool
    @State private var apps: [AppCarbonData] = []
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.white
                    .ignoresSafeArea()
                
                ScrollView {
                    VStack(spacing: 0) {
                        // Header
                        HStack {
                            Text("App Carbon Impact")
                                .font(.system(size: 28, weight: .bold))
                                .foregroundColor(.black)
                            
                            Spacer()
                        }
                        .padding(.horizontal, 24)
                        .padding(.top, 20)
                        .padding(.bottom, 24)
                        
                        // Summary Card
                        VStack(spacing: 20) {
                            HStack {
                                Text("Today's Impact")
                                    .font(.system(size: 18, weight: .bold))
                                    .foregroundColor(.black)
                                
                                Spacer()
                                
                                Text("0.24 kg CO₂")
                                    .font(.system(size: 18, weight: .bold))
                                    .foregroundColor(.blue)
                            }
                            
                            Text("Based on app usage patterns and server energy consumption")
                                .font(.system(size: 14, weight: .regular))
                                .foregroundColor(.gray)
                                .multilineTextAlignment(.leading)
                                .lineLimit(nil)
                        }
                        .padding(24)
                        .background(Color.white)
                        .cornerRadius(20)
                        .overlay(
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(Color.black, lineWidth: 2)
                        )
                        .padding(.horizontal, 24)
                        .padding(.bottom, 24)
                        
                        // Apps List
                        LazyVStack(spacing: 12) {
                            ForEach(apps) { app in
                                AppCarbonRow(app: app)
                            }
                        }
                        .padding(.horizontal, 24)
                    
                    Spacer()
                            .frame(height: 100)
                    }
                }
            }
            .navigationBarHidden(true)
        }
        .overlay(
            VStack {
                HStack {
                    Button("Done") {
                        isPresented = false
                    }
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(.blue)
                    
                    Spacer()
                }
                .padding(.horizontal, 24)
                .padding(.top, 20)
                
                Spacer()
            }
        )
        .onAppear {
            loadAppData()
        }
    }
    
    private func loadAppData() {
        apps = [
            AppCarbonData(
                id: UUID(),
                name: "Safari",
                usageHours: 1.8,
                carbonImpact: 0.045,
                category: "Web Browsing",
                efficiency: .medium
            ),
            AppCarbonData(
                id: UUID(),
                name: "Instagram",
                usageHours: 1.2,
                carbonImpact: 0.036,
                category: "Social Media",
                efficiency: .low
            ),
            AppCarbonData(
                id: UUID(),
                name: "Messages",
                usageHours: 0.9,
                carbonImpact: 0.018,
                category: "Communication",
                efficiency: .high
            ),
            AppCarbonData(
                id: UUID(),
                name: "YouTube",
                usageHours: 0.7,
                carbonImpact: 0.042,
                category: "Video Streaming",
                efficiency: .low
            ),
            AppCarbonData(
                id: UUID(),
                name: "Mail",
                usageHours: 0.5,
                carbonImpact: 0.015,
                category: "Communication",
                efficiency: .high
            ),
            AppCarbonData(
                id: UUID(),
                name: "Spotify",
                usageHours: 0.4,
                carbonImpact: 0.012,
                category: "Music Streaming",
                efficiency: .medium
            ),
            AppCarbonData(
                id: UUID(),
                name: "Maps",
                usageHours: 0.3,
                carbonImpact: 0.009,
                category: "Navigation",
                efficiency: .high
            ),
            AppCarbonData(
                id: UUID(),
                name: "Photos",
                usageHours: 0.2,
                carbonImpact: 0.006,
                category: "Media",
                efficiency: .high
            )
        ].sorted { $0.carbonImpact > $1.carbonImpact }
    }
}

struct AppCarbonData: Identifiable {
    let id: UUID
    let name: String
    let usageHours: Double
    let carbonImpact: Double
    let category: String
    let efficiency: CarbonEfficiency
}

enum CarbonEfficiency {
    case high, medium, low
    
    var color: Color {
        switch self {
        case .high: return .green
        case .medium: return .orange
        case .low: return .red
        }
    }
    
    var description: String {
        switch self {
        case .high: return "Efficient"
        case .medium: return "Moderate"
        case .low: return "High Impact"
        }
    }
}

struct AppCarbonRow: View {
    let app: AppCarbonData
    
    var body: some View {
        VStack(spacing: 16) {
            // App Header
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text(app.name)
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(.black)
                    
                    Text(app.category)
                        .font(.system(size: 12, weight: .medium))
                        .foregroundColor(.gray)
                }
                
                Spacer()
                
                VStack(alignment: .trailing, spacing: 4) {
                    Text(String(format: "%.3f", app.carbonImpact))
                        .font(.system(size: 18, weight: .bold))
                        .foregroundColor(.blue)
                    
                    Text("kg CO₂")
                        .font(.system(size: 10, weight: .medium))
                        .foregroundColor(.gray)
                }
            }
            
            // Usage Stats
            HStack(spacing: 20) {
                VStack(spacing: 4) {
                    Text(String(format: "%.1f", app.usageHours))
                        .font(.system(size: 16, weight: .bold))
                        .foregroundColor(.black)
                    
                    Text("hours")
                        .font(.system(size: 10, weight: .medium))
                        .foregroundColor(.gray)
                }
                
                VStack(spacing: 4) {
                    Text(app.efficiency.description)
                        .font(.system(size: 16, weight: .bold))
                        .foregroundColor(app.efficiency.color)
                    
                    Text("efficiency")
                        .font(.system(size: 10, weight: .medium))
                        .foregroundColor(.gray)
                }
                
                Spacer()
            }
        }
        .padding(20)
        .background(Color.white)
        .cornerRadius(16)
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(Color.gray.opacity(0.2), lineWidth: 1)
        )
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
                        .background(
                            GeometryReader { geometry in
                                Color.clear
                                    .onAppear {
                                        viewfinderFrame = geometry.frame(in: .global)
                                    }
                                    .onChange(of: geometry.frame(in: .global)) { newFrame in
                                        viewfinderFrame = newFrame
                                    }
                            }
                        )
                    
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
                            // Calculate crop rectangle relative to the camera preview
                            let screenBounds = UIScreen.main.bounds
                            
                            // The viewfinder is centered in the screen
                            let centerX = screenBounds.width / 2
                            let centerY = screenBounds.height / 2
                            
                            // Create a smaller, more focused square crop rectangle
                            let squareSize: CGFloat = 240  // Reduced from 280 to focus more
                            let rightOffset: CGFloat = 15  // Shift slightly to the right
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

// MARK: - Live Camera Preview
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
                                    .foregroundColor(.red)
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
                                        .background(Color.red)
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

