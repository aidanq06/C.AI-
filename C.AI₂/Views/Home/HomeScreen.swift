//
//  HomeScreen.swift
//  C.AI₂
//
//  Created by Aidan Quach on 10/24/25.
//

import SwiftUI
import AVFoundation

// MARK: - Home Screen
struct HomeScreen: View {
    @State private var showCamera = false
    @State private var showCameraPermissionAlert = false
    @State private var cameraPermissionStatus: AVAuthorizationStatus = .notDetermined
    @State private var showCarbonLog = false
    @StateObject private var carbonManager = CarbonFootprintManager.shared
    
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
                                                Text(String(format: "%.1f", carbonManager.dailyCO2))
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
                                        
                                        Text(String(format: "%.1f / 5.0 kg", carbonManager.dailyCO2))
                                            .font(.system(size: 12, weight: .medium))
                                            .foregroundColor(.gray)
                                    }
                                    
                                    // Horizontal Progress Bar
                                    VStack(spacing: 8) {
                                        // Progress Bar Background
                                        GeometryReader { geometry in
                                            let dailyUsage = carbonManager.dailyCO2
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
                                            Text("\(Int((carbonManager.dailyCO2 / 5.0) * 100))% of daily limit")
                                                .font(.system(size: 11, weight: .medium))
                                                .foregroundColor(.gray)
                                            
                                            Spacer()
                                            
                                            Text(carbonManager.dailyCO2 > 5.0 ? "Over Limit" : "Good")
                                                .font(.system(size: 11, weight: .semibold))
                                                .foregroundColor(carbonManager.dailyCO2 > 5.0 ? .red : .green)
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