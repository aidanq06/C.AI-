//
//  CarbonFootprintLogView.swift
//  C.AI₂
//
//  Created by Aidan Quach on 10/24/25.
//

import SwiftUI

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

