//
//  ScreenTimeScreen.swift
//  C.AI₂
//
//  Created by Aidan Quach on 10/24/25.
//

import SwiftUI

struct ScreenTimeScreen: View {
    @State private var totalScreenTime: Double = 0.0
    @State private var estimatedCO2: Double = 0.0
    @State private var topApps: [(String, Double)] = []
    @State private var isAnalyzing = true
    @State private var showAppBreakdown = false
    @State private var showAddToTotal = false
    @State private var showHelp = false
    @StateObject private var carbonManager = CarbonFootprintManager.shared
    
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

                            // Help Button
                            Button(action: {
                                showHelp = true
                            }) {
                                Image(systemName: "questionmark.circle")
                                    .font(.system(size: 20, weight: .regular))
                                    .foregroundColor(.gray)
                            }
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
                            .padding(.bottom, 24)
                            
                            if !isAnalyzing {
                                // Add to Daily Total Button
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
                                .padding(.horizontal, 24)
                                .padding(.bottom, 24)
                            }
                            
                            Spacer()
                                .frame(height: 100)
                        }
                    }
                }
            }
            .navigationBarHidden(true)
            .sheet(isPresented: $showAppBreakdown) {
                AppCarbonBreakdownView(isPresented: $showAppBreakdown)
            }
            .sheet(isPresented: $showHelp) {
                HelpView(isPresented: $showHelp, currentScreen: "Screen Time")
            }
            .onAppear {
                analyzeScreenTime()
            }
            .alert("Added to Daily Total", isPresented: $showAddToTotal) {
                Button("OK") {
                    // Add screen time CO2 to carbon manager
                    carbonManager.addCarbonEntry(
                        estimatedCO2,
                        itemName: "Screen Time",
                        icon: "iphone",
                        iconColor: .purple,
                        subtitle: "\(String(format: "%.1f", totalScreenTime)) hours today"
                    )
                }
            } message: {
                Text("Screen Time (\(String(format: "%.2f", estimatedCO2)) kg CO₂e) has been added to your daily carbon footprint.")
            }
        }
    }
    
    private func analyzeScreenTime() {
        // Simulate analysis delay
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            // Mock data - consistent values for testing
            self.totalScreenTime = 5.4 // hours
            self.estimatedCO2 = 0.27 // kg CO2 (5.4 hours * 0.05 kg/hour)
            self.topApps = [
                ("Safari", 1.8),
                ("Messages", 1.2),
                ("Instagram", 0.9),
                ("YouTube", 0.7),
                ("Mail", 0.5)
            ].sorted { $0.1 > $1.1 } // Sort by usage time descending

            self.isAnalyzing = false
        }
    }
}

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

                                Text("0.27 kg CO₂")
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
                carbonImpact: 0.090, // 1.8 hours * 0.05 kg/hour
                category: "Web Browsing",
                efficiency: .medium
            ),
            AppCarbonData(
                id: UUID(),
                name: "Instagram",
                usageHours: 1.2,
                carbonImpact: 0.060, // 1.2 hours * 0.05 kg/hour
                category: "Social Media",
                efficiency: .low
            ),
            AppCarbonData(
                id: UUID(),
                name: "Messages",
                usageHours: 0.9,
                carbonImpact: 0.045, // 0.9 hours * 0.05 kg/hour
                category: "Communication",
                efficiency: .high
            ),
            AppCarbonData(
                id: UUID(),
                name: "YouTube",
                usageHours: 0.7,
                carbonImpact: 0.035, // 0.7 hours * 0.05 kg/hour
                category: "Video Streaming",
                efficiency: .low
            ),
            AppCarbonData(
                id: UUID(),
                name: "Mail",
                usageHours: 0.5,
                carbonImpact: 0.025, // 0.5 hours * 0.05 kg/hour
                category: "Communication",
                efficiency: .high
            ),
            AppCarbonData(
                id: UUID(),
                name: "Other Apps",
                usageHours: 0.3,
                carbonImpact: 0.015, // 0.3 hours * 0.05 kg/hour
                category: "Various",
                efficiency: .medium
            )
        ].sorted { $0.carbonImpact > $1.carbonImpact }
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
