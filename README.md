# carbon.ai₂

Watch the app in action: https://www.youtube.com/watch?v=RE9tpsIcT-4

<img width="300" height="300" alt="ChatGPT Image Oct 26, 2025, 04_01_28 PM" src="https://github.com/user-attachments/assets/6a2b8b25-f245-4149-8fb9-43734bbbcf05" />


## What is this?

carbon.ai₂ is an iOS app that tracks your carbon footprint automatically. Just point your camera at food items, drive around, or use your phone, and the app calculates how much carbon dioxide you're generating.

The goal is simple: show people their environmental impact in real numbers, then help them make better choices.

<img width="200" height="500" alt="IMG_2582" src="https://github.com/user-attachments/assets/b2980811-ccda-4488-a9ac-8dc30cfb5a3d" />
<img width="200" height="500" alt="IMG_2583" src="https://github.com/user-attachments/assets/61b99de4-8f55-45b0-a80d-5c6095eb4ba1" />
<img width="200" height="500" alt="IMG_2584" src="https://github.com/user-attachments/assets/43828c14-ac37-4ea1-8daf-701eff8327dc" />
<img width="200" height="500" alt="IMG_2585" src="https://github.com/user-attachments/assets/7166d0b9-932e-444d-8e3e-92e1af473f7c" />

## How it works

### Home Screen - Here you can see the Carbon Footprint card, displaying your total carbon footprint in kilograms, and your daily usage. Your goal is to stay under 10 kilograms. There are also 2 widgets displaying your daily average and monthly goal. We can scan items to add to our carbon footprint.

<img width="200" height="500" alt="Simulator Screenshot - iPhone 17 - 2025-10-26 at 17 11 48" src="https://github.com/user-attachments/assets/04b8f0cf-f332-43e2-966c-8adf13f3e64c" />

### Scan items - Take a photo of food or products. The app uses AI to identify what it is and calculates the carbon impact. Something like a steak might show 2.4 kg of CO₂

<img width="200" height="500" alt="IMG_2578" src="https://github.com/user-attachments/assets/e8aa691d-d66d-4e1a-9e59-8768adb42576" />
<img width="300" height="500" alt="image" src="https://github.com/user-attachments/assets/11cc9830-a11d-48d9-a487-c0a703353017" />


### Track driving - The app automatically detects when you're in a car and logs your trips. It knows how far you went and calculates emissions based on distance and speed.

<img width="200" height="500" alt="IMG_2588" src="https://github.com/user-attachments/assets/d6dca538-daed-4504-b84b-f50091a4a113" />
<img width="200" height="500" alt="IMG_2587" src="https://github.com/user-attachments/assets/52c04e1f-e00b-4f15-8c60-8d7176587e6e" />

### Monitor screen time - Every hour you spend on your phone creates emissions from data centers and servers. The app tracks this and shows which apps use the most energy.

<img width="200" height="500" alt="IMG_2589" src="https://github.com/user-attachments/assets/2ab19591-1ea5-4759-878e-aab50058a805" />
<img width="200" height="500" alt="IMG_2590" src="https://github.com/user-attachments/assets/51b0f7d9-688d-4dc2-b348-7cdf514a87a0" />
<img width="200" height="500" alt="IMG_2591" src="https://github.com/user-attachments/assets/6477087f-7231-4738-8acf-e051ad25fa4f" />



### Get personalized tips - Based on your actual usage, the app suggests concrete ways to reduce your footprint. Want to cut 2 kg of CO₂ today? Here's how.

<img width="200" height="500" alt="IMG_2594" src="https://github.com/user-attachments/assets/768f6ad2-e613-40db-a920-186ae97c4d1f" />
<img width="200" height="500" alt="IMG_2593" src="https://github.com/user-attachments/assets/43340fd5-311a-4e45-b94d-120df641b889" />
<img width="200" height="500" alt="IMG_2592" src="https://github.com/user-attachments/assets/e44fb152-e001-447c-a9da-00c58c605481" />

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

