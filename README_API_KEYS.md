# 🔑 API Keys Setup

## ⚠️ Important Security Notice

**This repository is public.** Never commit your actual API keys!

The file `C.AI₂/Config/APIKeys.swift` is already in `.gitignore` and will NOT be committed to the repository.

## Setup Instructions

### 1. Get Your API Keys

#### Google Vision API
1. Go to [Google Cloud Console](https://console.cloud.google.com/)
2. Create or select a project
3. Enable "Cloud Vision API"
4. Go to "APIs & Services" > "Credentials"
5. Create an API Key
6. Copy the key

#### Gemini API
1. Go to [Google AI Studio](https://makersuite.google.com/app/apikey)
2. Create a new API key
3. Copy the key

### 2. Add Your Keys Locally

The file `C.AI₂/Config/APIKeys.swift` is already gitignored.

**Open it and add your keys:**

```swift
static let googleVisionAPIKey = "your_actual_vision_key_here"
static let geminiAPIKey = "your_actual_gemini_key_here"
```

### 3. Verify Setup

Run this to confirm your file won't be committed:

```bash
git status
```

You should NOT see `APIKeys.swift` in the output.

### 4. For Contributors

If you're cloning this repo, you'll need to:
1. Copy `Config/APIKeys.swift.template` to create your own `APIKeys.swift`
2. Add your own API keys
3. The file is gitignored so it won't be tracked

## Safety Checklist

- ✅ `APIKeys.swift` is in `.gitignore`
- ✅ Template file exists (`APIKeys.swift.template`)
- ✅ This README warns about security
- ✅ Never push real keys to the public repo

## Troubleshooting

If you accidentally committed `APIKeys.swift`:
1. Remove it from git: `git rm --cached C.AI₂/Config/APIKeys.swift`
2. Add to `.gitignore` (already done)
3. Commit the removal
4. Regenerate your API keys!

**Stay safe! 🛡️**

