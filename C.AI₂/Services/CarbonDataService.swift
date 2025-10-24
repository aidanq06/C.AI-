//
//  CarbonDataService.swift
//  C.AI₂
//
//  Manages carbon data persistence and calculations
//

import Foundation
import Combine

@MainActor
class CarbonDataService: ObservableObject {
    @Published var entries: [CarbonEntry] = []
    @Published var currentDailySummary: DailySummary?
    @Published var auraState: AuraState
    
    private let userDefaults = UserDefaults.standard
    private let entriesKey = "carbon_entries"
    
    init() {
        self.auraState = AuraState(dailyCO2: 0)
        loadEntries()
        calculateDailySummary()
    }
    
    // MARK: - Entry Management
    
    func addEntry(_ entry: CarbonEntry) {
        entries.insert(entry, at: 0)
        saveEntries()
        calculateDailySummary()
    }
    
    func deleteEntry(_ entry: CarbonEntry) {
        entries.removeAll { $0.id == entry.id }
        saveEntries()
        calculateDailySummary()
    }
    
    // MARK: - Daily Calculations
    
    func calculateDailySummary() {
        let today = Calendar.current.startOfDay(for: Date())
        let todayEntries = entries.filter {
            Calendar.current.isDate($0.timestamp, inSameDayAs: today)
        }
        
        let totalCO2 = todayEntries.reduce(0) { $0 + $1.co2Amount }
        
        var breakdown: [CarbonCategory: Double] = [:]
        for entry in todayEntries {
            breakdown[entry.category, default: 0] += entry.co2Amount
        }
        
        currentDailySummary = DailySummary(
            date: today,
            totalCO2: totalCO2,
            categoryBreakdown: breakdown,
            entryCount: todayEntries.count
        )
        
        // Update aura state
        auraState = AuraState(dailyCO2: totalCO2)
    }
    
    func getTodaysEntries() -> [CarbonEntry] {
        let today = Calendar.current.startOfDay(for: Date())
        return entries.filter {
            Calendar.current.isDate($0.timestamp, inSameDayAs: today)
        }
    }
    
    // MARK: - Persistence
    
    private func loadEntries() {
        guard let data = userDefaults.data(forKey: entriesKey),
              let decoded = try? JSONDecoder().decode([CarbonEntry].self, from: data) else {
            return
        }
        entries = decoded
    }
    
    private func saveEntries() {
        if let encoded = try? JSONEncoder().encode(entries) {
            userDefaults.set(encoded, forKey: entriesKey)
        }
    }
    
    // MARK: - Statistics
    
    func getWeeklyAverage() -> Double {
        let calendar = Calendar.current
        let weekAgo = calendar.date(byAdding: .day, value: -7, to: Date()) ?? Date()
        
        let recentEntries = entries.filter { $0.timestamp >= weekAgo }
        let totalCO2 = recentEntries.reduce(0) { $0 + $1.co2Amount }
        
        return totalCO2 / 7.0
    }
}

