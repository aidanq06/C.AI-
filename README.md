# carbon.ai₂

Watch the app in action: https://www.youtube.com/watch?v=RE9tpsIcT-4

<img width="300" height="300" alt="ChatGPT Image Oct 26, 2025, 04_01_28 PM" src="https://github.com/user-attachments/assets/6a2b8b25-f245-4149-8fb9-43734bbbcf05" />


## What is this?

carbon.ai₂ is an iOS app that tracks your carbon footprint automatically. Just point your camera at food items, drive around, or use your phone, and the app calculates how much carbon dioxide you're generating.

The goal is simple: show people their environmental impact in real numbers, then help them make better choices.

<img width="200" height="500" alt="IMG_2584" src="https://github.com/user-attachments/assets/43828c14-ac37-4ea1-8daf-701eff8327dc" />
<img width="200" height="500" alt="IMG_2583" src="https://github.com/user-attachments/assets/61b99de4-8f55-45b0-a80d-5c6095eb4ba1" />
<img width="200" height="500" alt="IMG_2582" src="https://github.com/user-attachments/assets/b2980811-ccda-4488-a9ac-8dc30cfb5a3d" />
<img width="200" height="500" alt="IMG_2585" src="https://github.com/user-attachments/assets/7166d0b9-932e-444d-8e3e-92e1af473f7c" />

## How it works

**Scan items** - Take a photo of food or products. The app uses AI to identify what it is and calculates the carbon impact. Something like a steak might show 2.4 kg of CO₂

<img width="200" height="500" alt="IMG_2578" src="https://github.com/user-attachments/assets/e8aa691d-d66d-4e1a-9e59-8768adb42576" />

**Track driving** - The app automatically detects when you're in a car and logs your trips. It knows how far you went and calculates emissions based on distance and speed.

**Monitor screen time** - Every hour you spend on your phone creates emissions from data centers and servers. The app tracks this and shows which apps use the most energy.

**Get personalized tips** - Based on your actual usage, the app suggests concrete ways to reduce your footprint. Want to cut 2 kg of CO₂ today? Here's how.

## Technical approach

The app uses Google's Vision API to identify objects in photos, then Google's Gemini AI to estimate carbon footprints. For driving, it uses location services to detect trips. For digital usage, it analyzes screen time patterns.

All data stays on the device and in local storage. The app works by capturing daily activity and presenting it in a clear, actionable format.

## Features

- Take photos of items to see their carbon impact
- Automatic driving detection and trip logging  
- Screen time tracking and digital footprint analysis
- AI-generated suggestions tailored to your habits
- Clean visual dashboard showing daily totals and trends

## Requirements

iPhone running iOS 14 or newer. The app needs camera access for scanning items and location access for tracking trips.

## Project structure

The codebase is organized into:
- Managers: Core functionality for camera, carbon tracking, AI integration
- Views: User interface screens for home, scanning, driving, screen time
- Models: Data structures representing carbon entries, trips, and usage data

See the demonstration video for a complete walkthrough: https://www.youtube.com/watch?v=RE9tpsIcT-4

## Setup

This project uses Xcode. API keys for Google Vision and Gemini are required and should be added to the Config folder. See the APIKeys.swift.template file for guidance.

Copyright 2024 Aidan Quach

