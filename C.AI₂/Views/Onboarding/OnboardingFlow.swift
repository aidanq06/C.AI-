//
//  OnboardingFlow.swift
//  C.AI₂
//
//  Created by Aidan Quach on 10/24/25.
//

import SwiftUI

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
                
                Text("your CO₂ emissions, visualized.")
                    .font(.system(size: 20, weight: .bold, design: .default))
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
                
                Text("your CO₂ emissions, visualized.")
                    .font(.system(size: 20, weight: .bold))
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
                
                VStack(spacing: 12) {
                    Button(action: {
                        // Placeholder action
                        hasCompletedOnboarding = true
                    }) {
                        Text("Get started")
                            .font(.system(size: 20, weight: .bold))
                            .foregroundColor(.black)
                    }
                    .padding(.top, 32)
                    
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
}

