//
//  InsightView.swift
//  C.AI₂
//
//  AI-generated daily insight presentation
//

import SwiftUI

struct InsightView: View {
    @Environment(\.dismiss) var dismiss
    let insight: String
    
    @State private var showText = false
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            
            VStack(spacing: 0) {
                // Close button
                HStack {
                    Spacer()
                    Button(action: { dismiss() }) {
                        Image(systemName: "xmark")
                            .font(.system(size: 18, weight: .light))
                            .foregroundColor(.white.opacity(0.6))
                    }
                }
                .padding(.horizontal, 24)
                .padding(.top, 20)
                
                Spacer()
                
                // Insight content
                VStack(spacing: 32) {
                    // Icon
                    Image(systemName: "sparkles")
                        .font(.system(size: 32, weight: .ultraLight))
                        .foregroundColor(.white.opacity(0.3))
                    
                    // Insight text
                    Text(insight)
                        .font(.system(size: 18, weight: .light, design: .rounded))
                        .foregroundColor(.white.opacity(0.8))
                        .multilineTextAlignment(.center)
                        .lineSpacing(8)
                        .padding(.horizontal, 40)
                        .opacity(showText ? 1 : 0)
                        .offset(y: showText ? 0 : 20)
                }
                
                Spacer()
                
                // Timestamp
                Text("Generated " + Date().formatted(date: .omitted, time: .shortened))
                    .font(.system(size: 11, weight: .light, design: .rounded))
                    .foregroundColor(.white.opacity(0.3))
                    .tracking(1)
                    .padding(.bottom, 50)
            }
        }
        .onAppear {
            withAnimation(.spring(response: 0.8, dampingFraction: 0.8).delay(0.2)) {
                showText = true
            }
        }
    }
}

#Preview {
    InsightView(insight: "Exceptional. You're operating at less than half the global average. This is the kind of day the planet needs.")
}

