//
//  DesignSystem.swift
//  C.AI₂
//
//  Core design tokens and styling
//

import SwiftUI

// MARK: - Typography

extension Font {
    static func caiTitle() -> Font {
        .system(size: 48, weight: .thin, design: .rounded)
    }
    
    static func caiBody() -> Font {
        .system(size: 15, weight: .light, design: .rounded)
    }
    
    static func caiCaption() -> Font {
        .system(size: 12, weight: .light, design: .rounded)
    }
    
    static func caiLabel() -> Font {
        .system(size: 11, weight: .medium, design: .rounded)
    }
}

// MARK: - Colors

extension Color {
    static let caiBackground = Color.black
    static let caiPrimary = Color.white
    static let caiSecondary = Color.white.opacity(0.6)
    static let caiTertiary = Color.white.opacity(0.3)
    static let caiAccent = Color(hue: 140/360, saturation: 0.7, brightness: 0.95) // Green
    
    static func caiGreen(for co2Level: Double) -> Color {
        if co2Level < 2.0 {
            return Color(hue: 140/360, saturation: 0.8, brightness: 0.95)
        } else if co2Level < 5.0 {
            return Color(hue: 120/360, saturation: 0.6, brightness: 0.9)
        } else {
            return Color.white.opacity(0.8)
        }
    }
}

// MARK: - Spacing

extension CGFloat {
    static let caiSpacingXS: CGFloat = 4
    static let caiSpacingS: CGFloat = 8
    static let caiSpacingM: CGFloat = 16
    static let caiSpacingL: CGFloat = 24
    static let caiSpacingXL: CGFloat = 32
    static let caiSpacing2XL: CGFloat = 48
}

// MARK: - Corner Radius

extension CGFloat {
    static let caiRadiusS: CGFloat = 8
    static let caiRadiusM: CGFloat = 12
    static let caiRadiusL: CGFloat = 16
    static let caiRadiusXL: CGFloat = 20
}

// MARK: - Animations

extension Animation {
    static let caiSpring = Animation.spring(response: 0.6, dampingFraction: 0.8)
    static let caiEaseOut = Animation.easeOut(duration: 0.3)
    static let caiEaseIn = Animation.easeIn(duration: 0.2)
}

// MARK: - View Modifiers

struct CAICardStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .background(
                RoundedRectangle(cornerRadius: .caiRadiusL, style: .continuous)
                    .fill(Color.white.opacity(0.03))
                    .overlay(
                        RoundedRectangle(cornerRadius: .caiRadiusL, style: .continuous)
                            .stroke(Color.white.opacity(0.08), lineWidth: 1)
                    )
            )
    }
}

struct CAIButtonStyle: ButtonStyle {
    let isLoading: Bool
    
    init(isLoading: Bool = false) {
        self.isLoading = isLoading
    }
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.96 : 1.0)
            .opacity(isLoading ? 0.5 : (configuration.isPressed ? 0.8 : 1.0))
            .animation(.caiSpring, value: configuration.isPressed)
    }
}

extension View {
    func caiCard() -> some View {
        modifier(CAICardStyle())
    }
}

// MARK: - Haptics

struct HapticManager {
    static func impact(style: UIImpactFeedbackGenerator.FeedbackStyle = .soft) {
        let generator = UIImpactFeedbackGenerator(style: style)
        generator.impactOccurred()
    }
    
    static func notification(type: UINotificationFeedbackGenerator.FeedbackType) {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(type)
    }
    
    static func selection() {
        let generator = UISelectionFeedbackGenerator()
        generator.selectionChanged()
    }
}

