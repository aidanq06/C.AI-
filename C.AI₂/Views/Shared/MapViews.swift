//
//  MapViews.swift
//  C.AI₂
//
//  Created by Aidan Quach on 10/24/25.
//

import SwiftUI
import MapKit

struct MapView: View {
    @ObservedObject var locationManager: LocationManager
    @Binding var isPresented: Bool
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4194),
        span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
    )
    
    var body: some View {
        NavigationView {
            ZStack {
                Map(coordinateRegion: $region)
                    .overlay(
                        MapPointsOverlay(coordinates: locationManager.routeCoordinates)
                    )
                
                VStack {
                    Spacer()
                    
                    // Bottom stats card
                    VStack(spacing: 16) {
                        HStack {
                            VStack(alignment: .leading, spacing: 4) {
                                Text("Distance")
                                    .font(.system(size: 14, weight: .regular))
                                    .foregroundColor(.gray)
                                
                                Text(String(format: "%.1f km", locationManager.totalDistance / 1000))
                                    .font(.system(size: 28, weight: .bold))
                                    .foregroundColor(.black)
                            }
                            
                            Spacer()
                            
                            VStack(alignment: .trailing, spacing: 4) {
                                Text("CO₂ Emissions")
                                    .font(.system(size: 14, weight: .regular))
                                    .foregroundColor(.gray)
                                
                                Text(String(format: "%.1f kg", locationManager.estimatedCO2))
                                    .font(.system(size: 28, weight: .bold))
                                    .foregroundColor(.red)
                            }
                        }
                        
                        HStack(spacing: 12) {
                            if locationManager.isTracking {
                                Button(action: {
                                    locationManager.stopTracking()
                                }) {
                                    Text("Stop Tracking")
                                        .font(.system(size: 16, weight: .semibold))
                                        .foregroundColor(.white)
                                        .frame(maxWidth: .infinity)
                                        .frame(height: 50)
                                        .background(Color.red)
                                        .cornerRadius(16)
                                }
                            } else {
                                Button(action: {
                                    locationManager.startTracking()
                                }) {
                                    Text("Start Tracking")
                                        .font(.system(size: 16, weight: .semibold))
                                        .foregroundColor(.white)
                                        .frame(maxWidth: .infinity)
                                        .frame(height: 50)
                                        .background(Color.red)
                                        .cornerRadius(16)
                                }
                            }
                            
                            Button(action: {
                                locationManager.stopTracking()
                                locationManager.totalDistance = 0.0
                                locationManager.estimatedCO2 = 0.0
                                locationManager.routeCoordinates.removeAll()
                            }) {
                                Text("Reset")
                                    .font(.system(size: 16, weight: .semibold))
                                    .foregroundColor(.black)
                                    .frame(maxWidth: .infinity)
                                    .frame(height: 50)
                                    .background(Color(.systemGray6))
                                    .cornerRadius(16)
                            }
                        }
                    }
                    .padding(24)
                    .background(Color.white)
                    .cornerRadius(24)
                    .padding(.horizontal, 24)
                    .padding(.bottom, 50)
                }
            }
            .navigationTitle("Route Tracking")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(
                leading: Button("Done") {
                    isPresented = false
                }
            )
        }
        .onAppear {
            if let location = locationManager.currentLocation {
                region.center = location.coordinate
            }
        }
        .onReceive(locationManager.$currentLocation) { location in
            if let location = location {
                region.center = location.coordinate
            }
        }
    }
}

struct MapPointsOverlay: View {
    let coordinates: [CLLocationCoordinate2D]

    var body: some View {
        GeometryReader { geometry in
            ForEach(coordinates.indices, id: \.self) { index in
                let point = convertCoordinateToPoint(coordinates[index], in: geometry.size)
                Circle()
                    .fill(Color.green)
                    .frame(width: 8, height: 8)
                    .position(point)
            }

            if coordinates.count > 1 {
                Path { path in
                    let startPoint = convertCoordinateToPoint(coordinates[0], in: geometry.size)
                    path.move(to: startPoint)

                    for coordinate in coordinates.dropFirst() {
                        let point = convertCoordinateToPoint(coordinate, in: geometry.size)
                        path.addLine(to: point)
                    }
                }
                .stroke(Color.green, lineWidth: 3)
            }
        }
    }

    private func convertCoordinateToPoint(_ coordinate: CLLocationCoordinate2D, in size: CGSize) -> CGPoint {
        let x = (coordinate.longitude + 180) / 360 * Double(size.width)
        let y = (90 - coordinate.latitude) / 180 * Double(size.height)
        return CGPoint(x: x, y: y)
    }
}

