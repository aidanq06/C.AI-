//
//  DrivingScreen.swift
//  C.AI₂
//
//  Created by Aidan Quach on 10/24/25.
//

import SwiftUI

struct DrivingScreen: View {
    @StateObject private var locationManager = LocationManager()
    @State private var showTripLog = false
    @State private var trips: [DetectedTrip] = []
    @State private var isTrackingEnabled = true
    
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
                                }
                    .padding(.horizontal, 24)
                    .padding(.top, 20)
                    .padding(.bottom, 24)
                                
                    // Large Logs Card
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
                            
                            // White Content Section
                            VStack(spacing: 0) {
                                // Single Trip - Campus to Downtown
                                VStack(spacing: 8) {
                                    // Trip Header
                                    HStack {
                                        VStack(alignment: .leading, spacing: 1) {
                                            Text("UF Campus → Downtown")
                                                .font(.system(size: 15, weight: .semibold))
                                                .foregroundColor(.black)
                                            
                                            Text("08:30 - 08:54 • 24 min")
                                                .font(.system(size: 11, weight: .medium))
                                                .foregroundColor(.gray)
                                        }
                                        
                                        Spacer()
                                        
                                        VStack(alignment: .trailing, spacing: 1) {
                                            Text("1.2")
                                                .font(.system(size: 16, weight: .bold))
                                                .foregroundColor(.red)
                                            
                                            Text("kg CO₂")
                                                .font(.system(size: 9, weight: .medium))
                                                .foregroundColor(.gray)
                                        }
                                    }
                                    
                                    // Map Trail
                                    ZStack {
                                        MapTrailView(routeID: 1)
                                        
                                        // Start point (campus)
                                        Circle()
                                            .fill(Color.white)
                                            .frame(width: 8, height: 8)
                                            .overlay(
                                                Circle()
                                                    .stroke(Color.purple, lineWidth: 2)
                                            )
                                            .offset(x: -50, y: 15)
                                        
                                        // End point (downtown)
                                        Circle()
                                            .fill(Color.purple)
                                            .frame(width: 8, height: 8)
                                            .overlay(
                                                Circle()
                                                    .stroke(Color.white, lineWidth: 1)
                                            )
                                            .offset(x: 50, y: 25)
                                    }
                                    
                                    // Trip Stats
                                    HStack(spacing: 12) {
                                        VStack(spacing: 1) {
                                            Text("3.2")
                                                .font(.system(size: 13, weight: .bold))
                                                .foregroundColor(.black)
                                            
                                            Text("miles")
                                                .font(.system(size: 8, weight: .medium))
                                                .foregroundColor(.gray)
                                        }
                                        
                                        VStack(spacing: 1) {
                                            Text("35")
                                                .font(.system(size: 13, weight: .bold))
                                                .foregroundColor(.black)
                                            
                                            Text("mph max")
                                                .font(.system(size: 8, weight: .medium))
                                                .foregroundColor(.gray)
                                        }
                                        
                                        VStack(spacing: 1) {
                                            Text("28")
                                                .font(.system(size: 13, weight: .bold))
                                                .foregroundColor(.black)
                                            
                                            Text("avg mph")
                                                .font(.system(size: 8, weight: .medium))
                                                .foregroundColor(.gray)
                                        }
                                        
                                        Spacer()
                                    }
                                }
                                .padding(12)
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

struct MapTrailView: View {
    let routeID: Int
    
    var body: some View {
        ZStack {
            // Apple Maps style background
            Rectangle()
                .fill(Color(red: 0.95, green: 0.95, blue: 0.95))
                .cornerRadius(16)
            
            // Campus buildings and roads (Apple Maps style)
            VStack(spacing: 0) {
                // Campus area (green spaces)
                Rectangle()
                    .fill(Color(red: 0.7, green: 0.9, blue: 0.7))
                    .frame(height: 40)
                
                // Urban area
                Rectangle()
                    .fill(Color(red: 0.9, green: 0.9, blue: 0.9))
                    .frame(height: 60)
            }
            
            // Roads
            Path { path in
                // University Avenue
                path.move(to: CGPoint(x: -60, y: 20))
                path.addLine(to: CGPoint(x: 60, y: 20))
                
                // 13th Street
                path.move(to: CGPoint(x: -20, y: -20))
                path.addLine(to: CGPoint(x: -20, y: 60))
            }
            .stroke(Color.white, lineWidth: 3)
            
            // Route trail (purple like Apple Maps)
            Path { path in
                path.move(to: CGPoint(x: -50, y: 15))
                path.addQuadCurve(to: CGPoint(x: -15, y: 5), control: CGPoint(x: -32, y: 10))
                path.addQuadCurve(to: CGPoint(x: 20, y: 15), control: CGPoint(x: 2, y: 8))
                path.addQuadCurve(to: CGPoint(x: 50, y: 25), control: CGPoint(x: 35, y: 20))
            }
            .stroke(Color.purple, lineWidth: 4)
            
            // Apple Maps watermark
            VStack {
                Spacer()
                HStack {
                    Text("Maps")
                        .font(.system(size: 8, weight: .medium))
                        .foregroundColor(.gray)
                                            Spacer()
                }
                .padding(.horizontal, 8)
                .padding(.bottom, 4)
            }
        }
        .frame(height: 100)
        .cornerRadius(16)
    }
}

struct TripLogView: View {
    @Binding var isPresented: Bool
    @State private var trips: [DetectedTrip] = []
    
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
                                    Text("3")
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
                                    Text("17.5")
                                        .font(.system(size: 24, weight: .bold))
                                        .foregroundColor(.red)
                                    
                                    Text("Total km")
                                        .font(.system(size: 12, weight: .medium))
                                        .foregroundColor(.gray)
                                }
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 16)
                                .background(Color.gray.opacity(0.05))
                                .cornerRadius(12)
                                
                                VStack(spacing: 8) {
                                    Text("2.1")
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

struct TripRow: View {
    @State var trip: DetectedTrip
    
    var body: some View {
        VStack(spacing: 16) {
            // Trip Header
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text("\(trip.startTime) - \(trip.endTime)")
                        .font(.system(size: 16, weight: .semibold))
                                            .foregroundColor(.black)
                    
                    Text(String(format: "%.1f km • Max: %.0f mph", trip.distance, trip.maxSpeed))
                        .font(.system(size: 12, weight: .medium))
                        .foregroundColor(.gray)
                }
                
                Spacer()
                
                VStack(alignment: .trailing, spacing: 4) {
                    Text(String(format: "%.1f", trip.co2Emissions))
                        .font(.system(size: 18, weight: .bold))
                        .foregroundColor(trip.co2Emissions > 0 ? .red : .green)
                    
                    Text("kg CO₂")
                        .font(.system(size: 10, weight: .medium))
                                        .foregroundColor(.gray)
                }
            }
                                    
            // Classification Buttons
            HStack(spacing: 12) {
                                    Button(action: {
                    trip.transportMode = .car
                }) {
                    Text("Car")
                        .font(.system(size: 14, weight: .medium))
                        .foregroundColor(trip.transportMode == .car ? .white : .gray)
                        .padding(.horizontal, 16)
                        .padding(.vertical, 8)
                        .background(trip.transportMode == .car ? Color.red : Color.gray.opacity(0.1))
                        .cornerRadius(8)
                }
                
                Button(action: {
                    trip.transportMode = .bus
                }) {
                    Text("Bus")
                        .font(.system(size: 14, weight: .medium))
                        .foregroundColor(trip.transportMode == .bus ? .white : .gray)
                        .padding(.horizontal, 16)
                        .padding(.vertical, 8)
                        .background(trip.transportMode == .bus ? Color.red : Color.gray.opacity(0.1))
                        .cornerRadius(8)
                }
                
                Spacer()
            }
        }
        .padding(20)
        .background(Color.white)
                                            .cornerRadius(16)
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(Color.gray.opacity(0.1), lineWidth: 1)
        )
    }
}

