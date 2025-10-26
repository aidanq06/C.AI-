//
//  HelpView.swift
//  C.AI₂
//
//  Created by Aidan Quach on 10/24/25.
//

import SwiftUI

struct HelpView: View {
    @Binding var isPresented: Bool
    let currentScreen: String

    var body: some View {
        NavigationView {
            ZStack {
                Color.white
                    .ignoresSafeArea()

                ScrollView {
                    VStack(spacing: 32) {
                        // Header Icon
                        VStack(spacing: 16) {
                            Image(systemName: "questionmark.circle.fill")
                                .font(.system(size: 64))
                                .foregroundColor(.green)

                            Text("Help & Guide")
                                .font(.system(size: 28, weight: .bold))
                                .foregroundColor(.black)

                            Text(currentScreen)
                                .font(.system(size: 16, weight: .medium))
                                .foregroundColor(.gray)
                        }
                        .padding(.top, 40)

                        // Content based on screen
                        VStack(spacing: 24) {
                            if currentScreen == "Home" {
                                homeHelpContent()
                            } else if currentScreen == "Driving" {
                                drivingHelpContent()
                            } else if currentScreen == "Screen Time" {
                                screenTimeHelpContent()
                            }
                        }
                        .padding(.horizontal, 24)

                        Spacer()
                            .frame(height: 40)
                    }
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(
                trailing: Button("Done") {
                    isPresented = false
                }
            )
        }
    }

    private func homeHelpContent() -> some View {
        VStack(alignment: .leading, spacing: 24) {
            HelpSection(
                icon: "leaf.fill",
                iconColor: .green,
                title: "Carbon Footprint Tracking",
                description: "View your daily carbon emissions in kg CO₂e. Each activity contributes to your total footprint."
            )

            HelpSection(
                icon: "camera.fill",
                iconColor: .black,
                title: "Scan Items",
                description: "Take a photo of items to automatically identify and calculate their carbon footprint using AI."
            )

            HelpSection(
                icon: "chart.bar.fill",
                iconColor: .blue,
                title: "Track Progress",
                description: "Monitor your daily average and monthly goals to reduce your environmental impact."
            )
        }
    }

    private func drivingHelpContent() -> some View {
        VStack(alignment: .leading, spacing: 24) {
            HelpSection(
                icon: "car.fill",
                iconColor: .blue,
                title: "Trip Tracking",
                description: "Automatically logs trips over 25 mph to track your driving emissions."
            )

            HelpSection(
                icon: "map.fill",
                iconColor: .red,
                title: "Trip Details",
                description: "View distance, speed, and CO₂ emissions for each trip. Categorize as car or bus."
            )

            HelpSection(
                icon: "arrow.clockwise",
                iconColor: .purple,
                title: "Add to Daily Total",
                description: "Tap 'Add Trips to Daily Total' to include driving emissions in your carbon footprint."
            )
        }
    }

    private func screenTimeHelpContent() -> some View {
        VStack(alignment: .leading, spacing: 24) {
            HelpSection(
                icon: "iphone",
                iconColor: .blue,
                title: "Digital Carbon Impact",
                description: "Your device usage generates emissions through data centers and server energy consumption."
            )

            HelpSection(
                icon: "chart.pie.fill",
                iconColor: .purple,
                title: "App Breakdown",
                description: "See which apps contribute most to your digital carbon footprint based on usage time."
            )

            HelpSection(
                icon: "leaf.fill",
                iconColor: .green,
                title: "Add to Total",
                description: "Include your digital carbon footprint in your daily emissions total for a complete picture."
            )
        }
    }
}

struct HelpSection: View {
    let icon: String
    let iconColor: Color
    let title: String
    let description: String

    var body: some View {
        HStack(alignment: .top, spacing: 16) {
            Image(systemName: icon)
                .font(.system(size: 24))
                .foregroundColor(iconColor)
                .frame(width: 44, height: 44)
                .background(iconColor.opacity(0.1))
                .cornerRadius(12)

            VStack(alignment: .leading, spacing: 6) {
                Text(title)
                    .font(.system(size: 17, weight: .semibold))
                    .foregroundColor(.black)

                Text(description)
                    .font(.system(size: 15, weight: .regular))
                    .foregroundColor(.gray)
                    .fixedSize(horizontal: false, vertical: true)
            }
        }
    }
}

