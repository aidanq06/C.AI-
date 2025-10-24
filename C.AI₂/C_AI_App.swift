//
//  C_AI_App.swift
//  C.AI₂
//
//  Created by Aidan Quach on 10/24/25.
//

import SwiftUI

@main
struct C_AI_App: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .onAppear {
                    // Request permissions on app launch
                    requestPermissions()
                }
        }
    }
    
    private func requestPermissions() {
        // Camera permission will be requested when camera is accessed
        // Location permission will be requested when location tracking starts
        // Photo library permission will be requested when gallery is accessed
    }
}
