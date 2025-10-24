//
//  LocationService.swift
//  C.AI₂
//
//  Handles location tracking and mobility emissions
//

import Foundation
import CoreLocation
import Combine

@MainActor
class LocationService: NSObject, ObservableObject {
    @Published var currentLocation: CLLocation?
    @Published var locationHistory: [LocationData] = []
    @Published var isAuthorized = false
    
    private let locationManager = CLLocationManager()
    private var lastSignificantLocation: CLLocation?
    private let minimumDistance: CLLocationDistance = 100 // meters
    
    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        locationManager.allowsBackgroundLocationUpdates = false
        locationManager.pausesLocationUpdatesAutomatically = true
        checkAuthorization()
    }
    
    func requestPermission() {
        locationManager.requestWhenInUseAuthorization()
    }
    
    func startTracking() {
        guard isAuthorized else {
            requestPermission()
            return
        }
        locationManager.startUpdatingLocation()
    }
    
    func stopTracking() {
        locationManager.stopUpdatingLocation()
    }
    
    private func checkAuthorization() {
        switch locationManager.authorizationStatus {
        case .authorizedWhenInUse, .authorizedAlways:
            isAuthorized = true
        case .notDetermined:
            isAuthorized = false
        case .restricted, .denied:
            isAuthorized = false
        @unknown default:
            isAuthorized = false
        }
    }
    
    func estimateMobilityEmissions(from start: CLLocation, to end: CLLocation) -> Double {
        let distance = end.distance(from: start) / 1000.0 // km
        
        // Simple heuristic: assume average car emissions ~0.12 kg CO2 per km
        // This could be refined with transport mode detection
        let emissionsPerKm = 0.12
        return distance * emissionsPerKm
    }
}

// MARK: - CLLocationManagerDelegate

extension LocationService: CLLocationManagerDelegate {
    nonisolated func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        Task { @MainActor in
            checkAuthorization()
        }
    }
    
    nonisolated func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        Task { @MainActor in
            guard let location = locations.last else { return }
            currentLocation = location
            
            // Track significant movements
            if let last = lastSignificantLocation {
                let distance = location.distance(from: last)
                if distance > minimumDistance {
                    let locationData = LocationData(coordinate: location.coordinate)
                    locationHistory.append(locationData)
                    lastSignificantLocation = location
                }
            } else {
                lastSignificantLocation = location
            }
        }
    }
}

