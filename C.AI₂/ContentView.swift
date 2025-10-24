//
//  ContentView.swift
//  C.AI₂
//
//  Created by Aidan Quach on 10/24/25.
//

import SwiftUI

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
                    .foregroundColor(.primary)
                    .padding(.top, 24)
                
                Spacer()
                
                Text("curated by")
                    .font(.system(size: 14, weight: .regular))
                    .foregroundColor(.gray)
                
                Text("Your Team")
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(.primary)
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
                    .foregroundColor(.primary)
                
                Text("made easy")
                    .font(.system(size: 34, weight: .bold))
                    .foregroundColor(.primary)
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
                    .foregroundColor(.primary)
                
                Text("daily footprint")
                    .font(.system(size: 38, weight: .bold))
                    .foregroundColor(.primary)
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
                                    .foregroundColor(.primary)
                                
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
                    .foregroundColor(.primary)
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
                        .foregroundColor(.primary)
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
                        .foregroundColor(.primary)
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
    @State private var selectedTab = 0
    
    var body: some View {
        TabView(selection: $selectedTab) {
            HomeScreen()
                .tag(0)
            
            SettingsScreen()
                .tag(1)
        }
    }
}

// MARK: - Home Screen
struct HomeScreen: View {
    @State private var showCamera = false
    
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
                            .foregroundColor(.primary)
                        
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
                    .padding(.top, 60)
                    .padding(.bottom, 32)
                    
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
                                        .foregroundColor(.primary)
                                    
                                    Text("kg CO₂e")
                                        .font(.system(size: 20, weight: .semibold))
                                        .foregroundColor(.gray)
                                }
                            }
                            
                            Spacer()
                        }
                    }
                    .padding(24)
                    .background(Color(.systemGray6))
                    .cornerRadius(24)
                    .padding(.horizontal, 24)
                    
                    Spacer()
                        .frame(height: 32)
                    
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
                    
                    // Bottom Navigation
                    HStack(spacing: 0) {
                        // Home Tab
                        VStack(spacing: 4) {
                            Image(systemName: "house.fill")
                                .font(.system(size: 24))
                                .foregroundColor(.primary)
                            
                            Text("Home")
                                .font(.system(size: 11, weight: .medium))
                                .foregroundColor(.primary)
                        }
                        .frame(maxWidth: .infinity)
                        
                        // Settings Tab
                        Button(action: {
                            // Navigate to settings
                        }) {
                            VStack(spacing: 4) {
                                Image(systemName: "gearshape")
                                    .font(.system(size: 24))
                                    .foregroundColor(.gray)
                                
                                Text("Settings")
                                    .font(.system(size: 11, weight: .medium))
                                    .foregroundColor(.gray)
                            }
                            .frame(maxWidth: .infinity)
                        }
                    }
                    .padding(.vertical, 12)
                    .background(Color.white)
                    .overlay(
                        Rectangle()
                            .fill(Color(.systemGray5))
                            .frame(height: 0.5),
                        alignment: .top
                    )
                }
            }
            .navigationBarHidden(true)
        }
        .sheet(isPresented: $showCamera) {
            CameraPlaceholder(isPresented: $showCamera)
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
                            .foregroundColor(.primary)
                        
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
                    
                    // Bottom Navigation
                    HStack(spacing: 0) {
                        // Home Tab
                        Button(action: {
                            // Navigate to home
                        }) {
                            VStack(spacing: 4) {
                                Image(systemName: "house")
                                    .font(.system(size: 24))
                                    .foregroundColor(.gray)
                                
                                Text("Home")
                                    .font(.system(size: 11, weight: .medium))
                                    .foregroundColor(.gray)
                            }
                            .frame(maxWidth: .infinity)
                        }
                        
                        // Settings Tab
                        VStack(spacing: 4) {
                            Image(systemName: "gearshape.fill")
                                .font(.system(size: 24))
                                .foregroundColor(.primary)
                            
                            Text("Settings")
                                .font(.system(size: 11, weight: .medium))
                                .foregroundColor(.primary)
                        }
                        .frame(maxWidth: .infinity)
                    }
                    .padding(.vertical, 12)
                    .background(Color.white)
                    .overlay(
                        Rectangle()
                            .fill(Color(.systemGray5))
                            .frame(height: 0.5),
                        alignment: .top
                    )
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
                    .foregroundColor(.primary)
                    .frame(width: 24)
                
                Text(title)
                    .font(.system(size: 17, weight: .regular))
                    .foregroundColor(.primary)
                
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

// MARK: - Camera Placeholder
struct CameraPlaceholder: View {
    @Binding var isPresented: Bool
    
    var body: some View {
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
                        // Info action
                    }) {
                        Image(systemName: "questionmark.circle")
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
                
                // Capture Button
                Button(action: {
                    // Capture action
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
                .padding(.bottom, 50)
            }
        }
    }
}

#Preview {
    ContentView()
}
