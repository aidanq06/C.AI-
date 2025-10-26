# C.AI₂ - Carbon Footprint Tracking App

Demonstration Video: https://www.youtube.com/watch?v=RE9tpsIcT-4

## Overview

carbon.ai₂ is an iOS application that leverages computer vision and machine learning to automatically track and analyze individual carbon footprints. The app uses Google's Vision API for image recognition and Google's Gemini AI to estimate carbon emissions, providing users with actionable insights to reduce their environmental impact.

## Architecture

The application follows a clean, modular architecture with separation of concerns:

### Core Components

**Managers/**
- `CarbonFootprintManager.swift`: Central state management for carbon tracking using ObservableObject pattern with published properties for reactive UI updates
- `CameraManager.swift`: Handles AVFoundation camera session management and photo capture with crop functionality
- `VisionAPIManager.swift`: Interfaces with Google Cloud Vision API for object identification from captured images
- `GeminiManager.swift`: Utilizes Google Gemini AI for carbon footprint estimation based on identified objects
- `LocationManager.swift`: CoreLocation integration for GPS-based driving detection and trip tracking

**Models/**
- `CarbonModels.swift`: Data structures for CarbonEntry, DetectedTrip, AppCarbonData, and related enums

**Views/**
- Home: Primary dashboard with total CO₂ display and activity log
- Camera: Image capture and analysis workflow
- Driving: Automatic trip detection and logging
- ScreenTime: Digital carbon footprint tracking
- Settings: User preferences and app configuration

## Technical Implementation

### Image Processing Pipeline

The app implements a two-stage analysis pipeline for scanned items:

1. Vision API Integration: Extracts object labels and descriptions from captured images
2. Gemini AI Processing: Generates carbon footprint estimates with contextual explanations

This dual-model approach ensures both accuracy in identification and contextual understanding of environmental impact.

### Data Persistence

UserDefaults stores daily carbon footprint totals and individual entries. The CarbonEntry struct implements Codable with custom encoding for SwiftUI Color properties, converting colors to hex strings for persistence and restoring them on load.

### Location Tracking

The LocationManager implements region monitoring to detect significant movements indicating driving trips. Speed and distance calculations trigger automatic trip logging when velocity exceeds thresholds.

## Features

- Real-time carbon footprint tracking across three categories: scanned items, driving trips, and digital usage
- AI-powered item identification using computer vision
- Automatic driving detection with trip logging
- Screen time carbon impact analysis
- Personalized reduction suggestions based on usage patterns
- Data visualization with progress indicators and categorical breakdowns

## API Integration

The application requires API keys for:
- Google Cloud Vision API: Image object detection
- Google Gemini API: Carbon footprint estimation

Keys should be added to `C.AI₂/Config/APIKeys.swift` following the template structure.

## Requirements

- iOS 14.0+
- Xcode 14.0+
- Active internet connection for API calls
- Camera permission for item scanning
- Location permission for driving detection

## Demonstration

For a complete walkthrough of the application features and implementation details, view the demonstration video at:

https://www.youtube.com/watch?v=RE9tpsIcT-4

## Project Structure

```
C.AI₂/
├── Config/
│   ├── APIKeys.swift
│   └── APIKeys.swift.template
├── Managers/
│   ├── CameraManager.swift
│   ├── CarbonFootprintManager.swift
│   ├── GeminiManager.swift
│   ├── LocationManager.swift
│   └── VisionAPIManager.swift
├── Models/
│   └── CarbonModels.swift
├── Views/
│   ├── Camera/
│   ├── Driving/
│   ├── Home/
│   ├── Onboarding/
│   ├── ScreenTime/
│   ├── Settings/
│   └── Shared/
└── Assets.xcassets/
```

## License

Copyright 2024 Aidan Quach. All rights reserved.

