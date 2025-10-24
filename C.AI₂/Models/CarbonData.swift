//
//  CarbonData.swift
//  C.AI₂
//
//  Core data models for carbon tracking
//

import Foundation
import CoreLocation

// MARK: - Carbon Entry
struct CarbonEntry: Identifiable, Codable {
    let id: UUID
    let timestamp: Date
    let co2Amount: Double // in kg
    let category: CarbonCategory
    let location: LocationData?
    let imageData: Data?
    let aiDescription: String?
    
    init(
        id: UUID = UUID(),
        timestamp: Date = Date(),
        co2Amount: Double,
        category: CarbonCategory,
        location: LocationData? = nil,
        imageData: Data? = nil,
        aiDescription: String? = nil
    ) {
        self.id = id
        self.timestamp = timestamp
        self.co2Amount = co2Amount
        self.category = category
        self.location = location
        self.imageData = imageData
        self.aiDescription = aiDescription
    }
}

// MARK: - Carbon Category
enum CarbonCategory: String, Codable, CaseIterable {
    case transport
    case food
    case energy
    case goods
    case mobility
    case other
    
    var displayName: String {
        switch self {
        case .transport: return "Transport"
        case .food: return "Food"
        case .energy: return "Energy"
        case .goods: return "Goods"
        case .mobility: return "Mobility"
        case .other: return "Other"
        }
    }
    
    var emoji: String {
        switch self {
        case .transport: return "🚗"
        case .food: return "🍽️"
        case .energy: return "⚡️"
        case .goods: return "📦"
        case .mobility: return "🚶"
        case .other: return "•"
        }
    }
}

// MARK: - Location Data
struct LocationData: Codable {
    let latitude: Double
    let longitude: Double
    let timestamp: Date
    
    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    
    init(coordinate: CLLocationCoordinate2D, timestamp: Date = Date()) {
        self.latitude = coordinate.latitude
        self.longitude = coordinate.longitude
        self.timestamp = timestamp
    }
}

// MARK: - Daily Summary
struct DailySummary: Identifiable, Codable {
    let id: UUID
    let date: Date
    let totalCO2: Double
    let categoryBreakdown: [CarbonCategory: Double]
    let aiInsight: String?
    let entryCount: Int
    
    init(
        id: UUID = UUID(),
        date: Date,
        totalCO2: Double,
        categoryBreakdown: [CarbonCategory: Double],
        aiInsight: String? = nil,
        entryCount: Int
    ) {
        self.id = id
        self.date = date
        self.totalCO2 = totalCO2
        self.categoryBreakdown = categoryBreakdown
        self.aiInsight = aiInsight
        self.entryCount = entryCount
    }
}

// MARK: - Aura State
struct AuraState {
    let co2Level: Double // Total CO2 for the day
    let intensity: Double // 0-1, drives size and glow
    let hue: Double // 0-360, green to white gradient
    let pulseRate: Double // Beats per minute
    
    init(dailyCO2: Double, baseline: Double = 5.0) {
        self.co2Level = dailyCO2
        
        // Calculate intensity (0-1) based on CO2 relative to baseline
        let ratio = dailyCO2 / baseline
        self.intensity = min(max(ratio, 0.1), 1.5)
        
        // Hue: green (120°) when low, approaches white (desaturated) when high
        if dailyCO2 < baseline * 0.5 {
            self.hue = 140 // Bright green
        } else if dailyCO2 < baseline {
            self.hue = 120 // Green
        } else if dailyCO2 < baseline * 1.5 {
            self.hue = 80 // Yellow-green
        } else {
            self.hue = 0 // White/minimal color
        }
        
        // Pulse rate increases with emissions
        self.pulseRate = 20 + (ratio * 10)
    }
}

