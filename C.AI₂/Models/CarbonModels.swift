//
//  CarbonModels.swift
//  C.AI₂
//
//  Created by Aidan Quach on 10/24/25.
//

import SwiftUI

// MARK: - Carbon Entry Model
struct CarbonEntry: Identifiable {
    let id: UUID
    let title: String
    let subtitle: String
    let co2Amount: Double
    let icon: String
    let iconColor: Color
    let timeAgo: String
}

// MARK: - AI Reduction Suggestion Model
struct AIReductionSuggestion: Identifiable {
    let id: UUID
    let title: String
    let impact: String
    let description: String
    let reasoning: String
    let difficulty: String
    let timeToImplement: String
    let category: String
}

// MARK: - Detected Trip Model
struct DetectedTrip: Identifiable {
    let id: UUID
    let date: Date
    let startTime: String
    let endTime: String
    let distance: Double
    let maxSpeed: Double
    let averageSpeed: Double
    var transportMode: TransportMode
    let co2Emissions: Double
}

enum TransportMode: String, CaseIterable {
    case car = "Car"
    case bus = "Bus"
    case unclassified = "Unclassified"
}

// MARK: - App Carbon Data Model
struct AppCarbonData: Identifiable {
    let id: UUID
    let name: String
    let usageHours: Double
    let carbonImpact: Double
    let category: String
    let efficiency: CarbonEfficiency
}

enum CarbonEfficiency {
    case high, medium, low
    
    var color: Color {
        switch self {
        case .high: return .green
        case .medium: return .orange
        case .low: return .red
        }
    }
    
    var description: String {
        switch self {
        case .high: return "Efficient"
        case .medium: return "Moderate"
        case .low: return "High Impact"
        }
    }
}

// MARK: - Captured Image Model
struct CapturedImage: Identifiable {
    let id = UUID()
    let image: UIImage
}

