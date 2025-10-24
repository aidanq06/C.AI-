//
//  SupabaseService.swift
//  C.AI₂
//
//  Supabase integration for cloud persistence
//

import Foundation

class SupabaseService {
    static let shared = SupabaseService()
    
    // In production: Add your Supabase URL and anon key
    private let supabaseURL = ProcessInfo.processInfo.environment["SUPABASE_URL"] ?? ""
    private let supabaseKey = ProcessInfo.processInfo.environment["SUPABASE_ANON_KEY"] ?? ""
    
    private init() {}
    
    // MARK: - User Data Sync
    
    func syncEntries(_ entries: [CarbonEntry]) async throws {
        // Implementation would sync entries to Supabase
        // For now, this is a placeholder structure
        
        guard !supabaseURL.isEmpty else {
            print("⚠️ Supabase not configured - data will be stored locally only")
            return
        }
        
        // Convert entries to JSON
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .iso8601
        let data = try encoder.encode(entries)
        
        // POST to Supabase
        guard let url = URL(string: "\(supabaseURL)/rest/v1/carbon_entries") else {
            throw SupabaseError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("Bearer \(supabaseKey)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("return=minimal", forHTTPHeaderField: "Prefer")
        request.httpBody = data
        
        let (_, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse,
              (200...299).contains(httpResponse.statusCode) else {
            throw SupabaseError.syncFailed
        }
    }
    
    func fetchEntries() async throws -> [CarbonEntry] {
        guard !supabaseURL.isEmpty else {
            return []
        }
        
        guard let url = URL(string: "\(supabaseURL)/rest/v1/carbon_entries") else {
            throw SupabaseError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.setValue("Bearer \(supabaseKey)", forHTTPHeaderField: "Authorization")
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200 else {
            throw SupabaseError.fetchFailed
        }
        
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        return try decoder.decode([CarbonEntry].self, from: data)
    }
    
    // MARK: - AI Service Integration
    
    func analyzeImageViaEdgeFunction(imageData: Data) async throws -> (description: String, co2: Double, category: CarbonCategory) {
        guard !supabaseURL.isEmpty else {
            throw SupabaseError.notConfigured
        }
        
        // Edge function endpoint
        guard let url = URL(string: "\(supabaseURL)/functions/v1/analyze-carbon") else {
            throw SupabaseError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("Bearer \(supabaseKey)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let body = ["image": imageData.base64EncodedString()]
        request.httpBody = try JSONEncoder().encode(body)
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200 else {
            throw SupabaseError.analysisFailed
        }
        
        let result = try JSONDecoder().decode(AnalysisResponse.self, from: data)
        return (result.description, result.co2, result.category)
    }
}

// MARK: - Supporting Types

enum SupabaseError: LocalizedError {
    case notConfigured
    case invalidURL
    case syncFailed
    case fetchFailed
    case analysisFailed
    
    var errorDescription: String? {
        switch self {
        case .notConfigured:
            return "Supabase is not configured. Data will be stored locally."
        case .invalidURL:
            return "Invalid Supabase URL"
        case .syncFailed:
            return "Failed to sync data with Supabase"
        case .fetchFailed:
            return "Failed to fetch data from Supabase"
        case .analysisFailed:
            return "Failed to analyze image"
        }
    }
}

struct AnalysisResponse: Codable {
    let description: String
    let co2: Double
    let category: CarbonCategory
}

