//
//  CarbonFootprintLogView.swift
//  C.AI₂
//
//  Created by Aidan Quach on 10/24/25.
//

import SwiftUI

struct CarbonFootprintLogView: View {
    @Binding var isPresented: Bool
    @StateObject private var carbonManager = CarbonFootprintManager.shared
    @State private var showAIReductionTips = false

    // Calculate totals from manager data
    private var totalEntries: Int { carbonManager.carbonEntries.count }
    private var totalCO2FromEntries: Double { carbonManager.carbonEntries.reduce(0) { $0 + $1.co2Amount } }
    
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

                                Text("Today")
                                    .font(.system(size: 15, weight: .medium))
                                    .foregroundColor(.gray)
                            }

                            HStack {
                                VStack(alignment: .leading, spacing: 8) {
                                    Text("Total Carbon Footprint")
                                        .font(.system(size: 17, weight: .regular))
                                        .foregroundColor(.gray)

                                    HStack(alignment: .firstTextBaseline, spacing: 6) {
                                        Text(String(format: "%.2f", carbonManager.dailyCO2))
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
                                ForEach(carbonManager.carbonEntries) { entry in
                                    CarbonEntryRow(entry: entry)
                                }

                                // Show message if no entries
                                if carbonManager.carbonEntries.isEmpty {
                                    VStack(spacing: 16) {
                                        Image(systemName: "leaf.circle")
                                            .font(.system(size: 48))
                                            .foregroundColor(.green.opacity(0.5))

                                        Text("No carbon footprint data yet")
                                            .font(.system(size: 18, weight: .medium))
                                            .foregroundColor(.gray)

                                        Text("Start by scanning items, logging trips, or analyzing your screen time")
                                            .font(.system(size: 14, weight: .regular))
                                            .foregroundColor(.gray)
                                            .multilineTextAlignment(.center)
                                    }
                                    .padding(.vertical, 40)
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
    }
    
}

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

