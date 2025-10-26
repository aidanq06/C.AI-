//
//  CarbonFootprintManager.swift
//  C.AI₂
//
//  Created by Aidan Quach on 10/24/25.
//

import Foundation
import Combine
import SwiftUI

class CarbonFootprintManager: ObservableObject {
    @Published var dailyCO2: Double = 0.0
    @Published var carbonEntries: [CarbonEntry] = []
    
    static let shared = CarbonFootprintManager()
    
    private let userDefaultsKey = "carbonFootprintData"
    private let scanCountKey = "scanCountKey"
    
    // Track which item to show for demo
    private var scanCount: Int {
        get {
            UserDefaults.standard.integer(forKey: scanCountKey)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: scanCountKey)
        }
    }
    
    init() {
        loadData()
    }
    
    func addCarbonEntry(_ amount: Double, itemName: String, icon: String, iconColor: Color, subtitle: String = "Just now") {
        let entry = CarbonEntry(
            id: UUID(),
            title: itemName,
            subtitle: subtitle,
            co2Amount: amount,
            icon: icon,
            iconColor: iconColor,
            timeAgo: subtitle
        )
        
        carbonEntries.insert(entry, at: 0)
        dailyCO2 += amount
        
        saveData()
    }
    
    // Add driving CO2
    func addDrivingCO2(_ amount: Double) {
        dailyCO2 += amount
        saveData()
    }
    
    // Add screen time CO2
    func addScreenTimeCO2(_ amount: Double) {
        dailyCO2 += amount
        saveData()
    }
    
    private func saveData() {
        let data: [String: Any] = [
            "dailyCO2": dailyCO2,
            "entriesCount": carbonEntries.count
        ]
        UserDefaults.standard.set(data, forKey: userDefaultsKey)
        
        // Also encode entries if needed for persistence
        if let encodedEntries = try? JSONEncoder().encode(carbonEntries) {
            UserDefaults.standard.set(encodedEntries, forKey: "\(userDefaultsKey)_entries")
        }
    }
    
    private func loadData() {
        if let data = UserDefaults.standard.dictionary(forKey: userDefaultsKey),
           let co2 = data["dailyCO2"] as? Double {
            dailyCO2 = co2
        }
        
        // Load entries if they exist
        if let data = UserDefaults.standard.data(forKey: "\(userDefaultsKey)_entries"),
           let decoded = try? JSONDecoder().decode([CarbonEntry].self, from: data) {
            carbonEntries = decoded
        }
    }
    
    func resetDailyCO2() {
        dailyCO2 = 0.0
        carbonEntries = []
        UserDefaults.standard.removeObject(forKey: userDefaultsKey)
        UserDefaults.standard.removeObject(forKey: "\(userDefaultsKey)_entries")
        // Reset scan count so first scan is beef, second is cheese
        UserDefaults.standard.removeObject(forKey: scanCountKey)
    }
    
    // For demo: track scan count to cycle through items
    func getNextScanItem() -> (name: String, co2: Double) {
        let current = scanCount
        scanCount += 1
        
        switch current {
        case 0:
            return ("Beef Steak", 2.4)
        case 1:
            return ("Cheese", 1.5)
        default:
            return ("Beef Steak", 2.4)
        }
    }
    
    func resetScanCount() {
        scanCount = 0
    }
}

// Make CarbonEntry Codable for persistence
extension CarbonEntry: Codable {
    enum CodingKeys: String, CodingKey {
        case id, title, subtitle, co2Amount, icon, iconColor, timeAgo
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(title, forKey: .title)
        try container.encode(subtitle, forKey: .subtitle)
        try container.encode(co2Amount, forKey: .co2Amount)
        try container.encode(icon, forKey: .icon)

        // Convert Color to hex string for encoding
        let colorHex = iconColor.toHex()
        try container.encode(colorHex, forKey: .iconColor)

        try container.encode(timeAgo, forKey: .timeAgo)
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(UUID.self, forKey: .id)
        title = try container.decode(String.self, forKey: .title)
        subtitle = try container.decode(String.self, forKey: .subtitle)
        co2Amount = try container.decode(Double.self, forKey: .co2Amount)
        icon = try container.decode(String.self, forKey: .icon)

        // Decode hex string back to Color
        let colorHex = try container.decode(String.self, forKey: .iconColor)
        iconColor = Color(hex: colorHex) ?? .blue

        timeAgo = try container.decode(String.self, forKey: .timeAgo)
    }
}

// Helper extensions for Color conversion
extension Color {
    func toHex() -> String {
        // Convert Color to UIColor for hex conversion
        let uiColor = UIColor(self)
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0

        uiColor.getRed(&red, green: &green, blue: &blue, alpha: &alpha)

        let rgb: Int = (Int)(red * 255) << 16 | (Int)(green * 255) << 8 | (Int)(blue * 255) << 0
        return String(format: "#%06x", rgb)
    }

    init?(hex: String) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")

        var rgb: UInt64 = 0

        guard Scanner(string: hexSanitized).scanHexInt64(&rgb) else {
            return nil
        }

        let red = Double((rgb & 0xFF0000) >> 16) / 255.0
        let green = Double((rgb & 0x00FF00) >> 8) / 255.0
        let blue = Double(rgb & 0x0000FF) / 255.0

        self.init(red: red, green: green, blue: blue)
    }
}

