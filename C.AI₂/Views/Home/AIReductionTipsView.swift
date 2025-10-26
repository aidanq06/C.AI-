//
//  AIReductionTipsView.swift
//  C.AI₂
//
//  Created by Aidan Quach on 10/24/25.
//

import SwiftUI

struct AIReductionTipsView: View {
    @Binding var isPresented: Bool
    @State private var suggestions: [AIReductionSuggestion] = []
    @State private var isAnalyzing = true
    @State private var showContent = false
    @State private var selectedCardId: UUID? = nil
    @StateObject private var carbonManager = CarbonFootprintManager.shared
    
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
            // DEMO MODE - HARDCODED SUGGESTIONS BASED ON CURRENT LOG
            // These suggestions match the items in the log (beef steak, cheese, 2 drives, screen time)
            // To restore dynamic AI suggestions, replace this with API calls to Gemini
            
            suggestions = [
                AIReductionSuggestion(
                    id: UUID(),
                    title: "Switch to Plant-Based Proteins",
                    impact: "Save 2.4 kg CO₂e per meal",
                    description: "Replace beef with plant-based alternatives like lentils, chickpeas, or Beyond Meat.",
                    reasoning: "Beef production generates 27kg CO₂e per kg. Plant proteins produce only 2kg CO₂e per kg - that's 93% less emissions. Your beef steak alone contributed 2.4kg today.",
                    difficulty: "Easy",
                    timeToImplement: "Next meal",
                    category: "Food"
                ),
                AIReductionSuggestion(
                    id: UUID(),
                    title: "Reduce Dairy Consumption",
                    impact: "Save 1.5 kg CO₂e weekly",
                    description: "Try oat milk, almond cheese, or reduce portion sizes of dairy products.",
                    reasoning: "Cheese produces 13.5kg CO₂e per kg. Your 1.5kg contribution today could be cut in half by choosing plant-based alternatives or smaller portions.",
                    difficulty: "Medium",
                    timeToImplement: "1 week",
                    category: "Food"
                ),
                AIReductionSuggestion(
                    id: UUID(),
                    title: "Carpool or Use Public Transit",
                    impact: "Save 2.1 kg CO₂e daily",
                    description: "Your two drives today (8.5km and 5.8km) could be combined or replaced with the RTS bus.",
                    reasoning: "Your 14.3km of driving generated 2.1kg CO₂e. The RTS bus route covers both trips with 70% fewer emissions. Carpooling with one person cuts your impact in half.",
                    difficulty: "Easy",
                    timeToImplement: "Tomorrow",
                    category: "Transportation"
                ),
                AIReductionSuggestion(
                    id: UUID(),
                    title: "Optimize Screen Time Usage",
                    impact: "Save 0.15 kg CO₂e daily",
                    description: "Enable dark mode, reduce brightness, and limit streaming video quality to 720p.",
                    reasoning: "Your 5.4 hours of screen time used 0.27kg CO₂e. Dark mode on OLED screens saves 60% power, and lower video quality reduces data center energy by 50%.",
                    difficulty: "Easy",
                    timeToImplement: "2 minutes",
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

