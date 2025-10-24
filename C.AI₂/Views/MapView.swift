//
//  MapView.swift
//  C.AI₂
//
//  Minimal monochrome map showing emission locations
//

import SwiftUI
import MapKit

struct MapView: View {
    @Environment(\.dismiss) var dismiss
    let entries: [CarbonEntry]
    
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4194),
        span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
    )
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            
            VStack(spacing: 0) {
                // Header
                header
                
                // Map
                mapView
                    .ignoresSafeArea(edges: .bottom)
            }
        }
        .onAppear {
            centerMapOnEntries()
        }
    }
    
    // MARK: - Components
    
    private var header: some View {
        HStack {
            Button(action: { dismiss() }) {
                Image(systemName: "xmark")
                    .font(.system(size: 18, weight: .light))
                    .foregroundColor(.white.opacity(0.6))
            }
            
            Spacer()
            
            Text("EMISSION MAP")
                .font(.system(size: 12, weight: .light, design: .rounded))
                .foregroundColor(.white.opacity(0.6))
                .tracking(2)
            
            Spacer()
            
            // Invisible spacer for centering
            Image(systemName: "xmark")
                .font(.system(size: 18, weight: .light))
                .foregroundColor(.clear)
        }
        .padding(.horizontal, 24)
        .padding(.vertical, 20)
    }
    
    private var mapView: some View {
        Map(position: .constant(.region(region))) {
            ForEach(entries.filter { $0.location != nil }) { entry in
                if let location = entry.location {
                    Annotation(
                        entry.aiDescription ?? "Entry",
                        coordinate: location.coordinate
                    ) {
                        EmissionMarker(
                            co2Amount: entry.co2Amount,
                            category: entry.category
                        )
                    }
                }
            }
        }
        .mapStyle(.standard(emphasis: .muted))
        .preferredColorScheme(.dark)
    }
    
    // MARK: - Helpers
    
    private func centerMapOnEntries() {
        let locations = entries.compactMap { $0.location }
        guard !locations.isEmpty else { return }
        
        let coordinates = locations.map { $0.coordinate }
        let avgLat = coordinates.reduce(0) { $0 + $1.latitude } / Double(coordinates.count)
        let avgLon = coordinates.reduce(0) { $0 + $1.longitude } / Double(coordinates.count)
        
        region = MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: avgLat, longitude: avgLon),
            span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        )
    }
}

// MARK: - Emission Marker

struct EmissionMarker: View {
    let co2Amount: Double
    let category: CarbonCategory
    
    var body: some View {
        ZStack {
            // Glow effect
            Circle()
                .fill(markerColor.opacity(0.2))
                .frame(width: size * 1.5, height: size * 1.5)
                .blur(radius: 4)
            
            // Main marker
            Circle()
                .fill(markerColor)
                .frame(width: size, height: size)
                .overlay(
                    Circle()
                        .stroke(Color.black, lineWidth: 1)
                )
        }
    }
    
    private var size: CGFloat {
        let base: CGFloat = 20
        let scaled = base + (CGFloat(co2Amount) * 3)
        return min(max(scaled, 16), 40)
    }
    
    private var markerColor: Color {
        if co2Amount < 0.5 {
            return Color.green
        } else if co2Amount < 2.0 {
            return Color.white.opacity(0.8)
        } else {
            return Color.white.opacity(0.6)
        }
    }
}

#Preview {
    MapView(entries: [
        CarbonEntry(
            co2Amount: 2.5,
            category: .transport,
            location: LocationData(
                coordinate: CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4194)
            )
        )
    ])
}

