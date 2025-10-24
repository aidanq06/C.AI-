//
//  AuraView.swift
//  C.AI₂
//
//  The core visualization - animated carbon aura
//

import SwiftUI

struct AuraView: View {
    let state: AuraState
    @State private var pulseAnimation = false
    @State private var rotationAnimation = false
    
    var body: some View {
        ZStack {
            // Background ambient glow
            Circle()
                .fill(
                    RadialGradient(
                        gradient: Gradient(colors: [
                            color(for: state).opacity(0.1),
                            Color.clear
                        ]),
                        center: .center,
                        startRadius: 50,
                        endRadius: 200
                    )
                )
                .frame(width: 400, height: 400)
                .blur(radius: 40)
                .opacity(pulseAnimation ? 0.6 : 0.3)
            
            // Main aura circle
            Circle()
                .fill(
                    RadialGradient(
                        gradient: Gradient(colors: [
                            color(for: state).opacity(0.8),
                            color(for: state).opacity(0.4),
                            color(for: state).opacity(0.1),
                            Color.clear
                        ]),
                        center: .center,
                        startRadius: 0,
                        endRadius: diameter / 2
                    )
                )
                .frame(width: diameter, height: diameter)
                .blur(radius: 2)
                .scaleEffect(pulseAnimation ? 1.05 : 1.0)
            
            // Inner core
            Circle()
                .fill(
                    LinearGradient(
                        gradient: Gradient(colors: [
                            color(for: state),
                            color(for: state).opacity(0.7)
                        ]),
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .frame(width: diameter * 0.85, height: diameter * 0.85)
                .blur(radius: 1)
            
            // CO2 reading overlay
            VStack(spacing: 4) {
                Text(String(format: "%.1f", state.co2Level))
                    .font(.system(size: 48, weight: .thin, design: .rounded))
                    .foregroundColor(.white)
                
                Text("kg CO₂")
                    .font(.system(size: 14, weight: .light, design: .rounded))
                    .foregroundColor(.white.opacity(0.7))
                    .tracking(2)
            }
        }
        .onAppear {
            startAnimations()
        }
        .onChange(of: state.co2Level) { _, _ in
            // Subtle impact on value change
            let impact = UIImpactFeedbackGenerator(style: .soft)
            impact.impactOccurred()
        }
    }
    
    // MARK: - Computed Properties
    
    private var diameter: CGFloat {
        let base: CGFloat = 220
        let scaled = base * CGFloat(state.intensity)
        return min(max(scaled, 180), 280)
    }
    
    private func color(for state: AuraState) -> Color {
        // Green for low emissions, fading to white for high
        let hue = state.hue / 360.0
        let saturation = state.co2Level < 5.0 ? 0.7 : max(0.1, 1.0 - (state.co2Level / 20.0))
        return Color(hue: hue, saturation: saturation, brightness: 0.95)
    }
    
    // MARK: - Animations
    
    private func startAnimations() {
        // Continuous pulse based on emission level
        let pulseDuration = 60.0 / state.pulseRate
        
        withAnimation(
            .easeInOut(duration: pulseDuration)
            .repeatForever(autoreverses: true)
        ) {
            pulseAnimation = true
        }
    }
}

// MARK: - Preview

#Preview {
    ZStack {
        Color.black.ignoresSafeArea()
        
        VStack(spacing: 60) {
            // Low emissions - green
            AuraView(state: AuraState(dailyCO2: 2.5))
            
            // Medium emissions
            AuraView(state: AuraState(dailyCO2: 5.0))
            
            // High emissions - white
            AuraView(state: AuraState(dailyCO2: 12.0))
        }
    }
}

