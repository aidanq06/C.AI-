//
//  AIService.swift
//  C.AI₂
//
//  AI vision and reasoning layer
//

import Foundation
import UIKit

@MainActor
class AIService: ObservableObject {
    @Published var isProcessing = false
    @Published var lastInsight: String?
    
    // Mock carbon database - in production, this would be a comprehensive API/database
    private let carbonDatabase: [String: (co2: Double, category: CarbonCategory)] = [
        "coffee": (0.21, .food),
        "latte": (0.34, .food),
        "burger": (3.5, .food),
        "steak": (7.2, .food),
        "salad": (0.5, .food),
        "banana": (0.08, .food),
        "apple": (0.06, .food),
        "water bottle": (0.08, .goods),
        "plastic bottle": (0.08, .goods),
        "paper cup": (0.05, .goods),
        "smartphone": (0.012, .goods), // Per day of use
        "laptop": (0.048, .goods), // Per day of use
        "car": (2.5, .transport), // Per typical journey
        "bus": (0.8, .transport),
        "bicycle": (0.0, .transport),
        "train": (0.6, .transport),
        "airplane": (90.0, .transport), // Short flight
        "shopping bag": (0.15, .goods),
        "package": (0.3, .goods),
        "shirt": (2.1, .goods),
        "shoes": (13.5, .goods),
        "book": (1.0, .goods),
    ]
    
    // MARK: - Vision Analysis
    
    func analyzeImage(_ image: UIImage) async -> (description: String, co2: Double, category: CarbonCategory)? {
        isProcessing = true
        defer { isProcessing = false }
        
        // Simulate API delay
        try? await Task.sleep(nanoseconds: 1_500_000_000)
        
        // In production: Send to Gemini Vision or similar API
        // For now: Mock intelligent recognition
        let mockResult = mockVisionAnalysis()
        
        return mockResult
    }
    
    private func mockVisionAnalysis() -> (description: String, co2: Double, category: CarbonCategory) {
        // Simulate vision model response
        let items = Array(carbonDatabase.keys)
        let randomItem = items.randomElement() ?? "item"
        let data = carbonDatabase[randomItem] ?? (0.5, .other)
        
        return (
            description: randomItem.capitalized,
            co2: data.co2,
            category: data.category
        )
    }
    
    // MARK: - Daily Insight Generation
    
    func generateDailyInsight(summary: DailySummary) async -> String {
        isProcessing = true
        defer { isProcessing = false }
        
        // Simulate API delay
        try? await Task.sleep(nanoseconds: 1_000_000_000)
        
        // In production: Send to LLM with context
        // For now: Rule-based insights with personality
        let insight = generateInsight(for: summary)
        lastInsight = insight
        
        return insight
    }
    
    private func generateInsight(for summary: DailySummary) -> String {
        let co2 = summary.totalCO2
        let avgUS = 16.0 // kg per day for average American
        let avgWorld = 4.0 // kg per day global average
        
        if co2 < 2.0 {
            return "Exceptional. You're operating at less than half the global average. This is the kind of day the planet needs."
        } else if co2 < avgWorld {
            return "Below the global average. Every choice compounds — you're proof of that."
        } else if co2 < avgUS * 0.7 {
            return "You're trending lower than most. The data shows restraint, but there's room to tighten the loop."
        } else if co2 < avgUS {
            return "Hovering near the American baseline. Consider where the highest concentrations lie — that's your leverage."
        } else if co2 < avgUS * 1.5 {
            return "Above baseline. The system reflects your inputs. Small recalibrations create exponential shifts."
        } else {
            return "High output detected. This is information, not judgment — use it to redirect momentum tomorrow."
        }
    }
    
    // MARK: - Carbon Estimation
    
    func estimateCarbonCost(for item: String) -> (co2: Double, category: CarbonCategory)? {
        let lowercased = item.lowercased()
        
        // Direct match
        if let data = carbonDatabase[lowercased] {
            return data
        }
        
        // Fuzzy matching
        for (key, value) in carbonDatabase {
            if lowercased.contains(key) || key.contains(lowercased) {
                return value
            }
        }
        
        return nil
    }
}

