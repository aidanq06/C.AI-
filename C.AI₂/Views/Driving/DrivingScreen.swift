//
//  DrivingScreen.swift
//  C.AI₂
//
//  Created by Aidan Quach on 10/24/25.
//

import SwiftUI

struct DrivingScreen: View {
    @StateObject private var locationManager = LocationManager()
    @StateObject private var carbonManager = CarbonFootprintManager.shared
    @State private var showTripLog = false
    @State private var trips: [DetectedTrip] = []
    @State private var isTrackingEnabled = true
    @State private var showAddToTotal = false
    @State private var showHelp = false
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.white
                    .ignoresSafeArea()
                
                VStack(spacing: 0) {
                    // Header
                    HStack {
                        Text("Driving")
                            .font(.system(size: 34, weight: .bold))
                            .foregroundColor(.black)

                        Spacer()

                        // Help Button
                        Button(action: {
                            showHelp = true
                        }) {
                            Image(systemName: "questionmark.circle")
                                .font(.system(size: 20, weight: .regular))
                                .foregroundColor(.gray)
                        }
                    }
                    .padding(.horizontal, 24)
                    .padding(.top, 20)
                    .padding(.bottom, 24)
                                
                    // Trip Logs Card
                    Button(action: {
                        showTripLog = true
                    }) {
                        VStack(spacing: 0) {
                            // Black Header Section
                            VStack(spacing: 0) {
                                HStack {
                                    Text("Trip Logs")
                                        .font(.system(size: 20, weight: .bold))
                                        .foregroundColor(.white)

                                    Spacer()

                                    Text("View All")
                                        .font(.system(size: 14, weight: .medium))
                                        .foregroundColor(.white.opacity(0.7))
                                }
                                .padding(.horizontal, 24)
                                .padding(.top, 24)
                                .padding(.bottom, 20)
                            }
                            .background(Color.black)

                            // White Content Section - Clean Trip Preview
                            VStack(spacing: 0) {
                                VStack(spacing: 16) {
                                    // Trip Info
                                    HStack {
                                        VStack(alignment: .leading, spacing: 4) {
                                            Text("UF Campus → Downtown")
                                                .font(.system(size: 16, weight: .semibold))
                                                .foregroundColor(.black)

                                            Text("08:30 - 08:54 • 24 min")
                                                .font(.system(size: 12, weight: .medium))
                                                .foregroundColor(.gray)
                                        }

                                        Spacer()

                                        VStack(alignment: .trailing, spacing: 2) {
                                            Text("1.2")
                                                .font(.system(size: 18, weight: .bold))
                                                .foregroundColor(.red)

                                            Text("kg CO₂")
                                                .font(.system(size: 10, weight: .medium))
                                                .foregroundColor(.gray)
                                        }
                                    }

                                    // Trip Stats Row
                                    HStack(spacing: 16) {
                                        VStack(spacing: 2) {
                                            Text("3.2")
                                                .font(.system(size: 14, weight: .bold))
                                                .foregroundColor(.black)

                                            Text("miles")
                                                .font(.system(size: 10, weight: .medium))
                                                .foregroundColor(.gray)
                                        }

                                        VStack(spacing: 2) {
                                            Text("35")
                                                .font(.system(size: 14, weight: .bold))
                                                .foregroundColor(.black)

                                            Text("mph max")
                                                .font(.system(size: 10, weight: .medium))
                                                .foregroundColor(.gray)
                                        }

                                        VStack(spacing: 2) {
                                            Text("28")
                                                .font(.system(size: 14, weight: .bold))
                                                .foregroundColor(.black)

                                            Text("avg mph")
                                                .font(.system(size: 10, weight: .medium))
                                                .foregroundColor(.gray)
                                        }

                                        Spacer()
                                    }
                                }
                                .padding(20)
                                .background(Color.white)
                                .cornerRadius(16)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 16)
                                        .stroke(Color.gray.opacity(0.2), lineWidth: 1)
                                )
                            }
                            .padding(.top, 12)
                            .padding(.bottom, 16)
                            .background(Color.white)
                        }
                        .cornerRadius(24)
                        .overlay(
                            RoundedRectangle(cornerRadius: 24)
                                .stroke(Color.black, lineWidth: 2)
                        )
                    }
                    .padding(.horizontal, 24)
                    
                    Spacer()
                        .frame(height: 20)
                    
                    // Today Widget - Combined Black Widget
                                VStack(spacing: 20) {
                                    HStack {
                            Text("Today")
                                .font(.system(size: 18, weight: .bold))
                                .foregroundColor(.white)
                                        
                                        Spacer()
                        }
                        
                        HStack(spacing: 16) {
                            // Trips Count
                            VStack(spacing: 8) {
                                Text("1")
                                    .font(.system(size: 28, weight: .bold))
                                    .foregroundColor(.white)
                                
                                Text("Trip")
                                    .font(.system(size: 12, weight: .medium))
                                    .foregroundColor(.white.opacity(0.7))
                            }
                            .frame(maxWidth: .infinity)
                            
                            // Total Distance
                            VStack(spacing: 8) {
                                Text("3.2")
                                    .font(.system(size: 28, weight: .bold))
                                    .foregroundColor(.white)
                                
                                Text("miles")
                                    .font(.system(size: 12, weight: .medium))
                                    .foregroundColor(.white.opacity(0.7))
                            }
                            .frame(maxWidth: .infinity)
                            
                            // CO2 Emissions
                            VStack(spacing: 8) {
                                Text("1.2")
                                    .font(.system(size: 28, weight: .bold))
                                    .foregroundColor(.white)
                                
                                Text("kg CO₂")
                                    .font(.system(size: 12, weight: .medium))
                                    .foregroundColor(.white.opacity(0.7))
                            }
                            .frame(maxWidth: .infinity)
                        }
                    }
                    .padding(24)
                    .background(Color.black)
                    .cornerRadius(20)
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(Color.black, lineWidth: 2)
                    )
                    .padding(.horizontal, 24)
                    .padding(.bottom, 24)

                    // Add Trips to Daily Total Button
                    Button(action: {
                        showAddToTotal = true
                    }) {
                        Text("Add Trips to Daily Total")
                            .font(.system(size: 17, weight: .semibold))
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .frame(height: 56)
                            .background(Color.black)
                            .cornerRadius(16)
                    }
                    .padding(.horizontal, 24)
                    .padding(.bottom, 24)

                    Spacer()
                        .frame(height: 20)

                    // Automatic Tracking Widget
                    VStack(spacing: 16) {
                        HStack {
                            Text("Automatic Tracking")
                                .font(.system(size: 18, weight: .bold))
                                .foregroundColor(.black)
                            
                            Spacer()
                            
                            Toggle("", isOn: $isTrackingEnabled)
                                .toggleStyle(SwitchToggleStyle(tint: .red))
                        }
                        
                        Text("Detects trips over 25 mph and logs them automatically")
                            .font(.system(size: 14, weight: .regular))
                            .foregroundColor(.gray)
                            .multilineTextAlignment(.leading)
                            .lineLimit(nil)
                            .fixedSize(horizontal: false, vertical: true)
                    }
                    .padding(24)
                    .background(Color.white)
                    .cornerRadius(20)
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(Color.black, lineWidth: 2)
                    )
                    .padding(.horizontal, 24)
                    
                    Spacer()
                }
            }
            .navigationBarHidden(true)
        }
        .sheet(isPresented: $showTripLog) {
            TripLogView(isPresented: $showTripLog)
        }
        .sheet(isPresented: $showHelp) {
            HelpView(isPresented: $showHelp, currentScreen: "Driving")
        }
        .onAppear {
            loadDemoTrips()
        }
        .alert("Added to Daily Total", isPresented: $showAddToTotal) {
            Button("OK") {
                // Add each trip to carbon manager
                for trip in trips where trip.co2Emissions > 0 {
                    let routeDescription = trip.distance > 0 ? "\(String(format: "%.1f", trip.distance)) km drive" : "Trip"
                    carbonManager.addCarbonEntry(
                        trip.co2Emissions,
                        itemName: routeDescription,
                        icon: "car.fill",
                        iconColor: .blue,
                        subtitle: "\(trip.startTime) - \(trip.endTime)"
                    )
                }
            }
        } message: {
            let totalCO2 = trips.compactMap { $0.co2Emissions }.reduce(0, +)
            Text("\(trips.filter { $0.co2Emissions > 0 }.count) trips (\(String(format: "%.2f", totalCO2)) kg CO₂e) have been added to your daily carbon footprint.")
        }
    }
    
    private func loadDemoTrips() {
        trips = [
            DetectedTrip(
                id: UUID(),
                date: Date(),
                startTime: "08:30",
                endTime: "08:54",
                distance: 8.5,
                maxSpeed: 45.0,
                averageSpeed: 32.0,
                transportMode: .unclassified,
                co2Emissions: 1.2
            ),
            DetectedTrip(
                id: UUID(),
                date: Calendar.current.date(byAdding: .hour, value: -3, to: Date()) ?? Date(),
                startTime: "12:15",
                endTime: "12:27",
                distance: 3.2,
                maxSpeed: 28.0,
                averageSpeed: 16.0,
                transportMode: .unclassified,
                co2Emissions: 0.0
            ),
            DetectedTrip(
                id: UUID(),
                date: Calendar.current.date(byAdding: .hour, value: -6, to: Date()) ?? Date(),
                startTime: "18:45",
                endTime: "19:03",
                distance: 5.8,
                maxSpeed: 52.0,
                averageSpeed: 29.0,
                transportMode: .unclassified,
                co2Emissions: 0.9
            )
        ]
    }
}


struct TripLogView: View {
    @Binding var isPresented: Bool
    @State private var trips: [DetectedTrip] = []

    // Calculate totals from trips data
    private var totalTrips: Int { trips.count }
    private var totalDistance: Double { trips.compactMap { $0.distance }.reduce(0, +) }
    private var totalCO2: Double { trips.compactMap { $0.co2Emissions }.reduce(0, +) }

    var body: some View {
        NavigationView {
            ZStack {
                Color.white
                    .ignoresSafeArea()

                ScrollView {
                    VStack(spacing: 0) {
                        // Header
                        HStack {
                            Text("Trip Log")
                                .font(.system(size: 28, weight: .bold))
                                .foregroundColor(.black)

                            Spacer()
                        }
                        .padding(.horizontal, 24)
                        .padding(.top, 20)
                        .padding(.bottom, 24)

                        // Summary Stats
                        VStack(spacing: 16) {
                            HStack(spacing: 16) {
                                VStack(spacing: 8) {
                                    Text("\(totalTrips)")
                                        .font(.system(size: 24, weight: .bold))
                                        .foregroundColor(.red)

                                    Text("Trips Today")
                                        .font(.system(size: 12, weight: .medium))
                                        .foregroundColor(.gray)
                                }
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 16)
                                .background(Color.gray.opacity(0.05))
                                .cornerRadius(12)

                                VStack(spacing: 8) {
                                    Text(String(format: "%.1f", totalDistance))
                                        .font(.system(size: 24, weight: .bold))
                                        .foregroundColor(.red)

                                    Text("Total miles")
                                        .font(.system(size: 12, weight: .medium))
                                        .foregroundColor(.gray)
                                }
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 16)
                                .background(Color.gray.opacity(0.05))
                                .cornerRadius(12)

                                VStack(spacing: 8) {
                                    Text(String(format: "%.1f", totalCO2))
                                        .font(.system(size: 24, weight: .bold))
                                        .foregroundColor(.red)

                                    Text("kg CO₂")
                                        .font(.system(size: 12, weight: .medium))
                                        .foregroundColor(.gray)
                                }
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 16)
                                .background(Color.gray.opacity(0.05))
                                .cornerRadius(12)
                            }
                        }
                        .padding(.horizontal, 24)
                        .padding(.bottom, 24)

                        // Trips List
                        LazyVStack(spacing: 12) {
                            ForEach(trips) { trip in
                                TripRow(trip: trip)
                            }
                        }
                        .padding(.horizontal, 24)

                        Spacer()
                            .frame(height: 100)
                    }
                }
            }
            .navigationBarHidden(true)
        }
        .overlay(
            VStack {
                HStack {
                    Button("Done") {
                        isPresented = false
                    }
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(.red)

                    Spacer()
                }
                .padding(.horizontal, 24)
                .padding(.top, 20)

                Spacer()
            }
        )
        .onAppear {
            loadDemoTrips()
        }
    }

    private func loadDemoTrips() {
        trips = [
            DetectedTrip(
                id: UUID(),
                date: Date(),
                startTime: "08:30",
                endTime: "08:54",
                distance: 3.2,
                maxSpeed: 45.0,
                averageSpeed: 32.0,
                transportMode: .car,
                co2Emissions: 1.2
            ),
            DetectedTrip(
                id: UUID(),
                date: Calendar.current.date(byAdding: .hour, value: -2, to: Date()) ?? Date(),
                startTime: "12:15",
                endTime: "12:27",
                distance: 1.8,
                maxSpeed: 28.0,
                averageSpeed: 18.0,
                transportMode: .car,
                co2Emissions: 0.7
            ),
            DetectedTrip(
                id: UUID(),
                date: Calendar.current.date(byAdding: .hour, value: -4, to: Date()) ?? Date(),
                startTime: "15:20",
                endTime: "15:35",
                distance: 2.4,
                maxSpeed: 35.0,
                averageSpeed: 24.0,
                transportMode: .car,
                co2Emissions: 0.9
            ),
            DetectedTrip(
                id: UUID(),
                date: Calendar.current.date(byAdding: .hour, value: -6, to: Date()) ?? Date(),
                startTime: "18:45",
                endTime: "19:03",
                distance: 4.1,
                maxSpeed: 52.0,
                averageSpeed: 31.0,
                transportMode: .car,
                co2Emissions: 1.5
            )
        ]
    }
}

struct TripRow: View {
    let trip: DetectedTrip

    var body: some View {
        VStack(spacing: 16) {
            // Trip Header
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text("UF Campus → Downtown")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(.black)

                    Text("\(trip.startTime) - \(trip.endTime) • \(calculateDuration(startTime: trip.startTime, endTime: trip.endTime))")
                        .font(.system(size: 12, weight: .medium))
                        .foregroundColor(.gray)
                }

                Spacer()

                VStack(alignment: .trailing, spacing: 2) {
                    Text(String(format: "%.1f", trip.co2Emissions))
                        .font(.system(size: 18, weight: .bold))
                        .foregroundColor(.red)

                    Text("kg CO₂")
                        .font(.system(size: 10, weight: .medium))
                        .foregroundColor(.gray)
                }
            }

            // Trip Stats Grid
            HStack(spacing: 20) {
                VStack(spacing: 4) {
                    Text(String(format: "%.1f", trip.distance))
                        .font(.system(size: 16, weight: .bold))
                        .foregroundColor(.black)

                    Text("miles")
                        .font(.system(size: 10, weight: .medium))
                        .foregroundColor(.gray)
                }

                VStack(spacing: 4) {
                    Text(String(format: "%.0f", trip.maxSpeed))
                        .font(.system(size: 16, weight: .bold))
                        .foregroundColor(.black)

                    Text("mph max")
                        .font(.system(size: 10, weight: .medium))
                        .foregroundColor(.gray)
                }

                VStack(spacing: 4) {
                    Text(String(format: "%.0f", trip.averageSpeed))
                        .font(.system(size: 16, weight: .bold))
                        .foregroundColor(.black)

                    Text("avg mph")
                        .font(.system(size: 10, weight: .medium))
                        .foregroundColor(.gray)
                }

                Spacer()
            }
        }
        .padding(20)
        .background(Color.white)
        .cornerRadius(16)
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(Color.gray.opacity(0.2), lineWidth: 1)
        )
    }

    private func calculateDuration(startTime: String, endTime: String) -> String {
        // Simple duration calculation - in a real app you'd parse the times properly
        let timeComponents = ["08:30-08:54": "24 min", "12:15-12:27": "12 min", "15:20-15:35": "15 min", "18:45-19:03": "18 min"]
        return timeComponents["\(startTime)-\(endTime)"] ?? "Unknown"
    }
}

