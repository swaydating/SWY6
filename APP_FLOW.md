# Sway App Flow Diagram

## App Launch Flow
```
SWY6App (@main)
    ↓
ContentView (Root Router)
    ├─ Not Authenticated → LoginView
    │                         ├─ Email Sign In
    │                         ├─ Phone Sign In → PhoneLoginView
    │                         ├─ Apple Sign In
    │                         ├─ Google Sign In
    │                         └─ Sign Up → SignUpView
    │
    └─ Authenticated
        ├─ Onboarding Incomplete → OnboardingContainerView
        │                             └─ 50 Step Flow
        │                                 ├─ Welcome & Basics (5 steps)
        │                                 ├─ Personal Info (9 steps)
        │                                 ├─ Location (2 steps)
        │                                 ├─ Preferences (5 steps)
        │                                 ├─ Lifestyle (11 steps)
        │                                 ├─ Interests (6 steps)
        │                                 ├─ Profile (4 steps)
        │                                 ├─ Verification (2 steps)
        │                                 └─ Final (6 steps)
        │
        └─ Onboarding Complete → MainTabView
                                    ├─ Tab 1: MatchingView (Discover)
                                    │           ├─ Swipe Cards
                                    │           ├─ Like/Dislike Actions
                                    │           └─ Match Animation
                                    │
                                    ├─ Tab 2: ChatListView (Messages)
                                    │           └─ ChatDetailView
                                    │                 └─ Message Bubbles
                                    │
                                    └─ Tab 3: ProfileView (Profile)
                                                ├─ View Profile
                                                ├─ Edit Profile
                                                └─ Settings → SettingsView
```

## Service Layer Architecture
```
ViewModels (ObservableObject)
    ↓ calls ↓
Services (Singleton Business Logic)
    ↓
    ├─ AuthService
    │   ├─ signInWithEmail()
    │   ├─ signInWithPhone()
    │   ├─ signInWithApple()
    │   ├─ signInWithGoogle()
    │   └─ signOut()
    │
    ├─ MatchService
    │   ├─ fetchPotentialMatches()
    │   ├─ swipe()
    │   └─ fetchMatches()
    │
    ├─ MessageService
    │   ├─ fetchConversations()
    │   ├─ sendMessage()
    │   └─ markAsRead()
    │
    ├─ LocationService
    │   ├─ requestPermission()
    │   └─ geocodeLocation()
    │
    └─ IDVerificationService
        ├─ uploadIDDocument()
        ├─ uploadSelfie()
        └─ checkVerificationStatus()
```

## Component Hierarchy

### Authentication Components
```
LoginView
├─ SocialSignInButton (Apple)
├─ SocialSignInButton (Google)
└─ CustomTextField × 2

PhoneLoginView
├─ CustomTextField (phone)
└─ CustomTextField (verification code)

SignUpView
├─ CustomTextField × 3
└─ SocialSignInButton × 2
```

### Onboarding Components
```
OnboardingContainerView
├─ ProgressBar
├─ Step Views (50 total)
│   ├─ WelcomeStepView
│   ├─ BasicInfoSteps
│   ├─ PersonalInfoSteps
│   ├─ PhysicalAttributeSteps
│   ├─ PreferenceSteps
│   ├─ LifestyleSteps
│   ├─ HobbySteps
│   ├─ AutocompleteSteps
│   ├─ ProfileSteps
│   ├─ VerificationSteps
│   ├─ LocationPermissionStepView
│   ├─ FinalSteps
│   └─ GenericStepView
└─ Navigation Buttons (Back/Next)
```

### Matching Components
```
MatchingView
├─ UserCardView (Card Stack)
│   ├─ Profile Image
│   ├─ User Info
│   └─ Interests Tags
├─ ActionButton (Dislike)
├─ ActionButton (Super Like)
├─ ActionButton (Like)
└─ MatchAnimationView (on match)
```

### Chat Components
```
ChatListView
└─ ChatRowView × n
    ├─ Profile Circle
    ├─ Name & Last Message
    └─ Timestamp

ChatDetailView
├─ MessageBubble × n
│   ├─ Sender Bubble (blue)
│   └─ Receiver Bubble (gray)
└─ Message Input Field
```

### Profile Components
```
ProfileView
├─ Profile Header
│   ├─ Profile Image
│   ├─ Name & Age
│   └─ Edit Button
├─ Bio Section
├─ Interests Section
├─ Photos Grid
└─ Settings
    ├─ SettingsRow × n
    └─ Sign Out Button
```

## Data Flow

### Authentication Flow
```
User Input (LoginView)
    ↓
AuthViewModel.signInWithEmail()
    ↓
AuthService.signInWithEmail()
    ↓
API Call (simulated)
    ↓
AuthService.currentUser = user
AuthService.isAuthenticated = true
    ↓
ContentView observes change
    ↓
Routes to OnboardingContainerView or MainTabView
```

### Onboarding Flow
```
User Completes Step
    ↓
OnboardingViewModel.nextStep()
    ↓
OnboardingViewModel.completedSteps.insert(currentStep)
OnboardingViewModel.currentStep = nextStep
    ↓
OnboardingContainerView renders new step
    ↓
Final Step: completeOnboarding()
    ↓
Updates AuthService.currentUser.onboardingCompleted
    ↓
ContentView routes to MainTabView
```

### Matching Flow
```
User Swipes Right
    ↓
MatchViewModel.swipeRight(user)
    ↓
MatchService.swipe(userId, .like)
    ↓
Check for match (50% for demo)
    ↓
If Match:
    MatchViewModel.showMatchAnimation = true
    MatchViewModel.newMatch = match
    └─ MatchAnimationView appears
```

### Messaging Flow
```
User Types Message
    ↓
ChatViewModel.messageText = "..."
    ↓
User Taps Send
    ↓
ChatViewModel.sendMessage()
    ↓
MessageService.sendMessage(content, matchId)
    ↓
API Call (simulated)
    ↓
Message added to ChatViewModel.messages
    ↓
ChatDetailView updates with new message
```

## State Management

### Published Properties
```swift
// AuthService
@Published var currentUser: User?
@Published var isAuthenticated: Bool
@Published var authState: AuthState

// OnboardingViewModel  
@Published var currentStep: OnboardingStep
@Published var completedSteps: Set<OnboardingStep>
@Published var userData: [String: Any]

// MatchViewModel
@Published var potentialMatches: [User]
@Published var currentMatches: [Match]
@Published var showMatchAnimation: Bool

// ChatViewModel
@Published var conversations: [Conversation]
@Published var messages: [Message]
@Published var messageText: String
```

## Key Design Patterns

1. **MVVM (Model-View-ViewModel)**
   - Models: Pure data structures
   - Views: SwiftUI views
   - ViewModels: ObservableObject with @Published properties

2. **Singleton Services**
   - AuthService.shared
   - MatchService.shared
   - MessageService.shared
   - LocationService.shared
   - IDVerificationService.shared

3. **Dependency Injection**
   - Services injected into ViewModels
   - @StateObject for ViewModel ownership
   - @ObservedObject for shared ViewModels

4. **Reactive Programming**
   - Combine framework
   - @Published properties
   - Async/await for asynchronous operations

5. **Component-Based Architecture**
   - Reusable components (PrimaryButton, CustomTextField, etc.)
   - Feature-organized components
   - Composition over inheritance