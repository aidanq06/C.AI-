//
//  GeminiManager.swift
//  C.AI₂
//
//  Created by Aidan Quach on 10/24/25.
//

import Foundation

class GeminiManager {
    private let apiKey: String
    
    init(apiKey: String) {
        self.apiKey = apiKey
    }
    
    private func getBaseURL() -> String {
        // Use the working Gemini endpoint
        return "https://generativelanguage.googleapis.com/v1beta/models/gemini-pro:generateContent?key=\(apiKey)"
    }
    
    func estimateCarbonFootprint(for itemDescription: String, completion: @escaping (Result<(Double, String), Error>) -> Void) {
        let prompt = """
        You are a carbon footprint calculator. Analyze these items and provide:
        1. A numerical value (carbon footprint in kg CO2e)
        2. A one-sentence explanation in 10 words or less
        
        Items: \(itemDescription)
        
        Format your response EXACTLY like this:
        NUMBER|EXPLANATION
        
        Example: 2.4|Beef production requires lots of land and water
        
        Rules:
        - Return ONLY the number and explanation separated by |
        - Number should be realistic (0.1 to 10 kg for food)
        - Explanation must be EXTREMELY simple (max 10 words)
        - Use plain language a child could understand
        """
        
        let requestBody: [String: Any] = [
            "contents": [
                [
                    "parts": [
                        [
                            "text": prompt
                        ]
                    ]
                ]
            ]
        ]
        
        guard let url = URL(string: getBaseURL()) else {
            completion(.failure(NSError(domain: "GeminiManager", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])))
            return
        }
        
        print("🌐 Gemini API URL: \(url.absoluteString)")
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: requestBody)
        } catch {
            completion(.failure(error))
            return
        }
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("❌ Gemini API Error: \(error.localizedDescription)")
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                print("❌ Gemini API Error: No data received")
                completion(.failure(NSError(domain: "GeminiManager", code: -1, userInfo: [NSLocalizedDescriptionKey: "No data received"])))
                return
            }
            
            // Log raw response for debugging
            if let httpResponse = response as? HTTPURLResponse {
                print("📡 Gemini API Status Code: \(httpResponse.statusCode)")
            }
            
            if let responseString = String(data: data, encoding: .utf8) {
                print("📥 Gemini API Response: \(responseString)")
            }
            
            do {
                if let json = try JSONSerialization.jsonObject(with: data) as? [String: Any] {
                    print("✅ Parsed Gemini JSON")
                    
                    if let error = json["error"] as? [String: Any] {
                        let errorMsg = error["message"] as? String ?? "Gemini API error"
                        print("❌ Gemini API Error from response: \(errorMsg)")
                        completion(.failure(NSError(domain: "GeminiManager", code: -1, userInfo: [NSLocalizedDescriptionKey: errorMsg])))
                        return
                    }
                    
                    if let candidates = json["candidates"] as? [[String: Any]],
                       let firstCandidate = candidates.first,
                       let content = firstCandidate["content"] as? [String: Any],
                       let parts = content["parts"] as? [[String: Any]],
                       let firstPart = parts.first,
                       let text = firstPart["text"] as? String {
                        
                        print("📝 Gemini Response Text: \(text)")
                        
                        // Parse format: NUMBER|EXPLANATION
                        let trimmedText = text.trimmingCharacters(in: .whitespacesAndNewlines)
                        let parts = trimmedText.components(separatedBy: "|")
                        
                        if parts.count >= 2 {
                            let numberString = parts[0].trimmingCharacters(in: .whitespacesAndNewlines)
                            let explanation = parts[1].trimmingCharacters(in: .whitespacesAndNewlines)
                            
                            if let value = Double(numberString) {
                                print("✅ Successfully parsed carbon footprint: \(value) kg")
                                print("💬 Explanation: \(explanation)")
                                completion(.success((value, explanation)))
                            } else {
                                print("❌ Could not parse numerical value: \(numberString)")
                                completion(.failure(NSError(domain: "GeminiManager", code: -1, userInfo: [NSLocalizedDescriptionKey: "Could not parse numerical value"])))
                            }
                        } else {
                            // Try to extract number if format is wrong
                            let cleanedString = trimmedText.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
                            if let value = Double(cleanedString) {
                                print("✅ Successfully parsed carbon footprint (no explanation): \(value) kg")
                                completion(.success((value, "High carbon emissions")))
                            } else {
                                print("❌ Could not parse response format")
                                completion(.failure(NSError(domain: "GeminiManager", code: -1, userInfo: [NSLocalizedDescriptionKey: "Could not parse response format"])))
                            }
                        }
                    } else {
                        print("❌ Failed to parse response structure")
                        completion(.failure(NSError(domain: "GeminiManager", code: -1, userInfo: [NSLocalizedDescriptionKey: "Failed to parse response"])))
                    }
                } else {
                    print("❌ Failed to parse JSON")
                    completion(.failure(NSError(domain: "GeminiManager", code: -1, userInfo: [NSLocalizedDescriptionKey: "Failed to parse JSON"])))
                }
            } catch {
                print("❌ JSON Parse Error: \(error)")
                if let dataString = String(data: data, encoding: .utf8) {
                    print("📥 Raw data: \(dataString)")
                }
                completion(.failure(error))
            }
        }.resume()
    }
}

