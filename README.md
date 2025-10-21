# Sway Dating App - SWY6

A modern, modular iOS dating app built with SwiftUI.

## Overview

Sway is a complete dating application with a clean, modular architecture. The codebase has been rebuilt from a monolithic structure into 50+ well-organized Swift files.

## Features

### Authentication
- ✅ Email/Password sign-in
- ✅ Phone number authentication with SMS verification
- ✅ Social sign-in (Apple, Google, Facebook)
- ✅ Multi-step authentication flow
- ✅ Password strength validation

### Onboarding (40+ Steps)
- Personal Information (name, DOB, gender, height, ethnicity, body type, hair/eye color)
- Location & Permissions
- Preferences (age range, distance, gender preferences)
- Relationship Goals
- Lifestyle (smoking, drinking, exercise, diet, drugs)
- Family (children, want children)
- Religion & Politics
- Interests & Hobbies
- Music, Movies, Books, Sports preferences
- Bio & Profile creation
- Photo upload (2-6 photos)
- Profile video (optional)
- ID Verification
- Photo Verification
- Notifications preferences
- Terms & Conditions
- Profile review

### Core Features
- 🔥 Swipe matching interface
- 💬 Real-time chat messaging
- 👤 User profiles
- 📍 Location-based matching
- ✅ ID & photo verification
- ⚙️ Comprehensive settings
- 🎓 Onboarding walkthrough

### Autocomplete
- Location search (cities)
- Occupation suggestions
- Education/School suggestions

## Architecture

### Project Structure
```
SWY6/
├── Models/              # Data models
│   ├── User.swift
│   ├── Match.swift
│   ├── Message.swift
│   ├── AuthCredentials.swift
│   └── OnboardingStep.swift
│
├── Views/               # Main view containers
│   ├── ContentView.swift
│   └── MainTabView.swift
│
├── ViewModels/          # Business logic
│   ├── AuthViewModel.swift
│   ├── OnboardingViewModel.swift
│   ├── MatchViewModel.swift
│   └── ChatViewModel.swift
│
├── Services/            # API & Business services
│   ├── AuthService.swift
│   ├── MatchService.swift
│   ├── MessageService.swift
│   ├── LocationService.swift
│   └── IDVerificationService.swift
│
├── Components/          # Reusable UI components
│   ├── Auth/           # Login, signup, phone auth
│   ├── Onboarding/     # All onboarding steps
│   ├── Matching/       # Swipe interface
│   ├── Chat/           # Messaging UI
│   ├── Profile/        # User profile
│   ├── Settings/       # App settings
│   ├── IDVerification/ # Verification flow
│   ├── Walkthrough/    # Tutorial
│   └── Common/         # Shared components
│
├── Extensions/          # Swift extensions
│   ├── CommonExtensions.swift
│   └── ViewExtensions.swift
│
├── Utils/              # Utilities & helpers
│   ├── Constants.swift
│   └── ValidationHelper.swift
│
├── SWY6App.swift       # App entry point (@main)
└── Info.plist         # App configuration

```

## Key Components

### Single @main Entry Point
- `SWY6App.swift` - The only app entry point with @main attribute

### No Duplicates
- Each struct/class is defined once
- No duplicate functionality
- Clean separation of concerns

### Modular Design
- **Models**: Pure data structures
- **Views**: SwiftUI UI components
- **ViewModels**: ObservableObject classes for state management
- **Services**: Singleton business logic services
- **Components**: Organized by feature area

## Requirements
- iOS 15.0+
- Xcode 14.0+
- Swift 5.7+

## Build Instructions

1. Open the project in Xcode
2. Select your target device or simulator
3. Build and run (⌘R)

## Features Implementation

### Authentication Flow
```swift
LoginView → PhoneLoginView → SignUpView
    ↓
AuthService (handles all auth)
    ↓
ContentView (routes based on auth state)
```

### Onboarding Flow
```swift
OnboardingContainerView
    ↓
50+ individual step views
    ↓
OnboardingViewModel (manages progress)
```

### Matching Flow
```swift
MatchingView
    ↓
MatchService (handles swipe actions)
    ↓
MatchAnimationView (on successful match)
```

## File Count
- **Total Swift Files**: 50+
- **Models**: 5
- **ViewModels**: 4
- **Services**: 5
- **Views**: 2
- **Components**: 35+
- **Extensions**: 2
- **Utils**: 2

## License
Proprietary - Sway Dating App

## Version
1.0.0
