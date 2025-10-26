//
//  VisionAPIManager.swift
//  C.AI₂
//
//  Created by Aidan Quach on 10/24/25.
//

import Foundation
import UIKit

class VisionAPIManager {
    private let apiKey: String
    private let baseURL = "https://vision.googleapis.com/v1/images:annotate"
    
    init(apiKey: String) {
        self.apiKey = apiKey
    }
    
    func analyzeImage(_ image: UIImage, completion: @escaping (Result<String, Error>) -> Void) {
        guard let imageData = image.jpegData(compressionQuality: 0.8) else {
            completion(.failure(NSError(domain: "VisionAPIManager", code: -1, userInfo: [NSLocalizedDescriptionKey: "Failed to convert image to data"])))
            return
        }
        
        let base64Image = imageData.base64EncodedString()
        
        let requestBody: [String: Any] = [
            "requests": [
                [
                    "image": [
                        "content": base64Image
                    ],
                    "features": [
                        [
                            "type": "OBJECT_LOCALIZATION",
                            "maxResults": 5
                        ],
                        [
                            "type": "LABEL_DETECTION",
                            "maxResults": 10
                        ]
                    ]
                ]
            ]
        ]
        
        guard let url = URL(string: "\(baseURL)?key=\(apiKey)") else {
            completion(.failure(NSError(domain: "VisionAPIManager", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])))
            return
        }
        
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
                print("❌ Vision API Error: \(error.localizedDescription)")
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                print("❌ Vision API Error: No data received")
                completion(.failure(NSError(domain: "VisionAPIManager", code: -1, userInfo: [NSLocalizedDescriptionKey: "No data received"])))
                return
            }
            
            // Log raw response for debugging
            if let httpResponse = response as? HTTPURLResponse {
                print("📡 Vision API Status Code: \(httpResponse.statusCode)")
            }
            
            if let responseString = String(data: data, encoding: .utf8) {
                print("📥 Vision API Response: \(responseString)")
            }
            
            do {
                guard let json = try JSONSerialization.jsonObject(with: data) as? [String: Any] else {
                    print("❌ Failed to parse JSON")
                    completion(.failure(NSError(domain: "VisionAPIManager", code: -1, userInfo: [NSLocalizedDescriptionKey: "Failed to parse JSON"])))
                    return
                }
                
                print("✅ Parsed Vision API JSON")
                
                guard let responses = json["responses"] as? [[String: Any]],
                      let firstResponse = responses.first else {
                    print("❌ Failed to parse responses")
                    completion(.failure(NSError(domain: "VisionAPIManager", code: -1, userInfo: [NSLocalizedDescriptionKey: "Failed to parse response"])))
                    return
                }
                
                // Check for API errors
                if let error = firstResponse["error"] as? [String: Any] {
                    let errorMsg = error["message"] as? String ?? "Vision API error"
                    print("❌ Vision API Error from response: \(errorMsg)")
                    completion(.failure(NSError(domain: "VisionAPIManager", code: -1, userInfo: [NSLocalizedDescriptionKey: errorMsg])))
                    return
                }
                
                var detectedItems: [String] = []
                
                // Check for localized objects first
                if let localizedObjectAnnotations = firstResponse["localizedObjectAnnotations"] as? [[String: Any]] {
                    for annotation in localizedObjectAnnotations {
                        if let name = annotation["name"] as? String {
                            detectedItems.append(name)
                            print("🔍 Object: \(name)")
                        }
                    }
                }
                
                // Fallback to labels if no objects detected
                if detectedItems.isEmpty, let labelAnnotations = firstResponse["labelAnnotations"] as? [[String: Any]] {
                    for annotation in labelAnnotations.prefix(5) {
                        if let description = annotation["description"] as? String {
                            detectedItems.append(description)
                            print("🏷️ Label: \(description)")
                        }
                    }
                }
                
                if detectedItems.isEmpty {
                    print("⚠️ No labels found in response")
                    completion(.failure(NSError(domain: "VisionAPIManager", code: -1, userInfo: [NSLocalizedDescriptionKey: "No labels detected"])))
                    return
                }
                
                let description = detectedItems.joined(separator: ", ")
                completion(.success(description))
                
            } catch {
                print("❌ JSON Parse Error: \(error)")
                completion(.failure(error))
            }
        }.resume()
    }
}
