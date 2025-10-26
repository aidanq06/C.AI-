//
//  LocationManager.swift
//  C.AI₂
//
//  Created by Aidan Quach on 10/24/25.
//

import Foundation
import CoreLocation
import MapKit
import Combine

// MARK: - Location Manager
class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    private let locationManager = CLLocationManager()
    @Published var isTracking: Bool = false
    @Published var totalDistance: Double = 0.0
    @Published var estimatedCO2: Double = 0.0
    @Published var currentLocation: CLLocation?
    @Published var routeCoordinates: [CLLocationCoordinate2D] = []
    
    private var lastLocation: CLLocation?
    private var startLocation: CLLocation?
    
    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = 10 // Update every 10 meters
    }
    
    func startTracking() {
        guard locationManager.authorizationStatus == .authorizedWhenInUse || 
              locationManager.authorizationStatus == .authorizedAlways else {
            locationManager.requestWhenInUseAuthorization()
            return
        }
        
        isTracking = true
        routeCoordinates.removeAll()
        totalDistance = 0.0
        estimatedCO2 = 0.0
        lastLocation = nil
        startLocation = nil
        
        locationManager.startUpdatingLocation()
    }
    
    func stopTracking() {
        isTracking = false
        locationManager.stopUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last, isTracking else { return }
        
        currentLocation = location
        
        if startLocation == nil {
            startLocation = location
        }
        
        if let lastLocation = lastLocation {
            let distance = location.distance(from: lastLocation)
            totalDistance += distance
            
            // Estimate CO2 emissions (average car: ~120g CO2 per km)
            let co2PerKm = 0.12 // kg CO2 per km
            estimatedCO2 = (totalDistance / 1000) * co2PerKm
        }
        
        lastLocation = location
        routeCoordinates.append(location.coordinate)
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .authorizedWhenInUse, .authorizedAlways:
            if isTracking {
                locationManager.startUpdatingLocation()
            }
        case .denied, .restricted:
            isTracking = false
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        @unknown default:
            break
        }
    }
}

