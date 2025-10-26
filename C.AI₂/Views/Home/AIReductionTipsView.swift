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

