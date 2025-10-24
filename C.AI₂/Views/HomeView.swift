//
//  HomeView.swift
//  C.AI₂
//
//  Main interface - the carbon state screen
//

import SwiftUI

struct HomeView: View {
    @StateObject private var carbonData = CarbonDataService()
    @StateObject private var aiService = AIService()
    @StateObject private var cameraService = CameraService()
    @StateObject private var locationService = LocationService()
    
    @State private var showingCapture = false
    @State private var showingMap = false
    @State private var showingInsight = false
    @State private var dailyInsight: String?
    
    var body: some View {
        ZStack {
            // Pure black background
            Color.black
                .ignoresSafeArea()
            
            VStack(spacing: 0) {
                // Top bar - minimal
                topBar
                    .padding(.top, 60)
                    .padding(.horizontal, 24)
                
                Spacer()
                
                // Center - The Aura
                auraSection
                
                Spacer()
                
                // Bottom - Quick stats and actions
                statsSection
                    .padding(.bottom, 40)
            }
            
            // Floating capture button
            captureButton
        }
        .sheet(isPresented: $showingCapture) {
            CaptureView(
                carbonData: carbonData,
                aiService: aiService,
                cameraService: cameraService,
                locationService: locationService
            )
        }
        .sheet(isPresented: $showingMap) {
            MapView(entries: carbonData.getTodaysEntries())
        }
        .sheet(isPresented: $showingInsight) {
            InsightView(insight: dailyInsight ?? "")
        }
        .onAppear {
            cameraService.checkAuthorization()
            locationService.startTracking()
            loadDailyInsight()
        }
    }
    
    // MARK: - Components
    
    private var topBar: some View {
        HStack {
            // Date indicator
            Text(Date().formatted(date: .abbreviated, time: .omitted))
                .font(.system(size: 13, weight: .light, design: .rounded))
                .foregroundColor(.white.opacity(0.5))
                .tracking(1)
            
            Spacer()
            
            // Map toggle
            Button(action: { showingMap = true }) {
                Image(systemName: "map")
                    .font(.system(size: 16, weight: .light))
                    .foregroundColor(.white.opacity(0.6))
            }
        }
    }
    
    private var auraSection: some View {
        VStack(spacing: 32) {
            // The Aura
            AuraView(state: carbonData.auraState)
                .transition(.scale.combined(with: .opacity))
            
            // Status text
            Text(statusText)
                .font(.system(size: 15, weight: .light, design: .rounded))
                .foregroundColor(.white.opacity(0.6))
                .tracking(1.5)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 40)
        }
    }
    
    private var statusText: String {
        let co2 = carbonData.auraState.co2Level
        if co2 < 2.0 {
            return "MINIMAL IMPACT"
        } else if co2 < 5.0 {
            return "BALANCED STATE"
        } else if co2 < 10.0 {
            return "ELEVATED OUTPUT"
        } else {
            return "HIGH INTENSITY"
        }
    }
    
    private var statsSection: some View {
        VStack(spacing: 24) {
            // Category breakdown
            if let summary = carbonData.currentDailySummary, !summary.categoryBreakdown.isEmpty {
                categoryBreakdown(summary.categoryBreakdown)
                    .transition(.opacity.combined(with: .move(edge: .bottom)))
            }
            
            // Daily insight button
            if let summary = carbonData.currentDailySummary, summary.entryCount > 0 {
                Button(action: {
                    showingInsight = true
                }) {
                    HStack(spacing: 8) {
                        Image(systemName: "sparkles")
                            .font(.system(size: 12, weight: .light))
                        
                        Text("VIEW INSIGHT")
                            .font(.system(size: 12, weight: .medium, design: .rounded))
                            .tracking(1.5)
                    }
                    .foregroundColor(.white.opacity(0.7))
                    .padding(.vertical, 12)
                    .padding(.horizontal, 24)
                    .background(
                        Capsule()
                            .fill(Color.white.opacity(0.05))
                            .overlay(
                                Capsule()
                                    .stroke(Color.white.opacity(0.1), lineWidth: 1)
                            )
                    )
                }
                .transition(.opacity.combined(with: .move(edge: .bottom)))
            }
        }
        .padding(.horizontal, 24)
    }
    
    private func categoryBreakdown(_ breakdown: [CarbonCategory: Double]) -> some View {
        HStack(spacing: 16) {
            ForEach(breakdown.sorted(by: { $0.value > $1.value }).prefix(4), id: \.key) { category, amount in
                VStack(spacing: 6) {
                    Text(String(format: "%.1f", amount))
                        .font(.system(size: 16, weight: .medium, design: .rounded))
                        .foregroundColor(.white)
                    
                    Text(category.displayName.uppercased())
                        .font(.system(size: 9, weight: .light, design: .rounded))
                        .foregroundColor(.white.opacity(0.5))
                        .tracking(1)
                }
                .frame(maxWidth: .infinity)
            }
        }
        .padding(.vertical, 16)
        .padding(.horizontal, 20)
        .background(
            RoundedRectangle(cornerRadius: 16, style: .continuous)
                .fill(Color.white.opacity(0.03))
                .overlay(
                    RoundedRectangle(cornerRadius: 16, style: .continuous)
                        .stroke(Color.white.opacity(0.08), lineWidth: 1)
                )
        )
    }
    
    private var captureButton: some View {
        VStack {
            Spacer()
            
            Button(action: {
                let impact = UIImpactFeedbackGenerator(style: .medium)
                impact.impactOccurred()
                showingCapture = true
            }) {
                ZStack {
                    // Outer glow ring
                    Circle()
                        .fill(
                            RadialGradient(
                                gradient: Gradient(colors: [
                                    Color.white.opacity(0.1),
                                    Color.clear
                                ]),
                                center: .center,
                                startRadius: 30,
                                endRadius: 50
                            )
                        )
                        .frame(width: 100, height: 100)
                    
                    // Main button
                    Circle()
                        .fill(Color.white)
                        .frame(width: 64, height: 64)
                        .overlay(
                            Image(systemName: "camera")
                                .font(.system(size: 24, weight: .light))
                                .foregroundColor(.black)
                        )
                }
            }
            .padding(.bottom, 50)
        }
    }
    
    // MARK: - Helpers
    
    private func loadDailyInsight() {
        guard let summary = carbonData.currentDailySummary else { return }
        
        Task {
            dailyInsight = await aiService.generateDailyInsight(summary: summary)
        }
    }
}

#Preview {
    HomeView()
}

