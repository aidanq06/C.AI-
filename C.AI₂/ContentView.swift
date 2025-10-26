//
//  ContentView.swift
//  C.AI₂
//
//  Created by Aidan Quach on 10/24/25.
//

import SwiftUI

struct ContentView: View {
    @State private var showOnboarding = true
    @State private var hasCompletedOnboarding = false
    
    var body: some View {
        if hasCompletedOnboarding {
            MainTabView()
        } else {
            OnboardingFlow(hasCompletedOnboarding: $hasCompletedOnboarding)
        }
    }
}

// MARK: - Main Tab View
struct MainTabView: View {
    var body: some View {
        TabView {
            HomeScreen()
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Home")
                }
            
            DrivingScreen()
                .tabItem {
                    Image(systemName: "car.fill")
                    Text("Driving")
                }
            
            ScreenTimeScreen()
                .tabItem {
                    Image(systemName: "iphone")
                    Text("Screen Time")
                }
            
            SettingsScreen()
                .tabItem {
                    Image(systemName: "gearshape.fill")
                    Text("Settings")
                }
        }
        .accentColor(.black)
    }
}

