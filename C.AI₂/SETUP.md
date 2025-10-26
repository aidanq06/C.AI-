# C.AI₂ - Scan Item Setup

## Overview
The app now uses Google Vision API and Gemini API to scan items and estimate their carbon footprint.

## Setup Instructions

### 1. Get Google Cloud API Keys

1. **Vision API Key**:
   - Go to [Google Cloud Console](https://console.cloud.google.com/)
   - Create a new project or select existing one
   - Enable "Cloud Vision API"
   - Go to "APIs & Services" > "Credentials"
   - Create an API Key
   - Copy the key

2. **Gemini API Key**:
   - Go to [Google AI Studio](https://makersuite.google.com/app/apikey)
   - Create a new API key for Gemini
   - Copy the key

### 2. Configure API Keys

**IMPORTANT:** `APIKeys.swift` is gitignored to protect your keys!

1. The file `Config/APIKeys.swift` is already gitignored
2. Open `C.AI₂/Config/APIKeys.swift` 
3. Replace the placeholders with your actual keys:

```swift
static let googleVisionAPIKey = "YOUR_VISION_API_KEY_HERE"
static let geminiAPIKey = "YOUR_GEMINI_API_KEY_HERE"
```

**Never commit this file with real keys!** It's already in `.gitignore`.

### 3. Add API Keys to Privacy (Important!)

Add to your `Info.plist`:

```xml
<key>NSCameraUsageDescription</key>
<string>C.AI₂ needs camera access to scan items and calculate their carbon footprint.</string>
```

### 4. How It Works

1. **User taps "Scan Item"** button
2. Camera opens to capture photo
3. Photo is analyzed using Google Vision API to identify the item
4. Item description is sent to Gemini API with a prompt engineered to return ONLY a numerical value
5. Carbon footprint (kg CO₂e) is displayed
6. When user adds it, the daily CO₂ card updates automatically

### 5. Prompt Engineering

The Gemini prompt is specifically designed to:
- Return ONLY a numerical value
- No units, no text, no explanations
- Just the carbon footprint in kg CO₂e
- Example response: "2.4" (not "2.4 kg" or "The carbon footprint is 2.4 kg")

### 6. Dynamic Updates

The home screen now shows:
- Real-time daily CO₂ values
- Dynamic progress bars
- Percentage calculations
- Visual indicators (Good/Over Limit)

### 7. Testing

1. Add your API keys to `APIKeys.swift`
2. Build and run the app
3. Tap "Scan Item"
4. Capture a photo of any item
5. Wait for analysis (Vision → Gemini → Display)
6. Tap "Add to Daily Total"
7. Watch the home screen CO₂ card update in real-time

## Technical Flow

```
Photo → Vision API (identify item) → Gemini API (calculate footprint) → Display → Save to CarbonManager → Update UI
```

## Files Modified/Created

- `Managers/VisionAPIManager.swift` - Google Vision API integration
- `Managers/GeminiManager.swift` - Gemini API integration  
- `Managers/CarbonFootprintManager.swift` - State management for CO₂ data
- `Views/Camera/CameraViews.swift` - Updated analysis flow
- `Views/Home/HomeScreen.swift` - Dynamic CO₂ display
- `Config/APIKeys.swift` - API key configuration

## Notes

- The app uses a singleton `CarbonFootprintManager.shared` for global state
- Daily CO₂ persists between app launches via UserDefaults
- The Vision API returns top 3 labels, Gemini uses them to calculate footprint
- Gemini prompt is engineered to return ONLY numerical values
- UI updates automatically via `@Published` properties
