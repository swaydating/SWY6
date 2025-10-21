// OnboardingStep.swift
// This file defines the onboarding steps for the application.

enum OnboardingStep {
    case locationPermission
    case gender
    case orientation
    case interestedIn
    case relationship
    case distancePreference
    case height
    case education
    case employment
    case industry
    case school
    case drinking
    case favouriteDrink
    case workout
    case smoking
    case religion
    case kidsPreference
    case cultural
    case favourites
    case personalBackground
    case appearanceStyle
    case personality
    case hobbiesInterests
    case dateNight
    case lifestyle
    case pets
    case sports
    case hobbies
    case politicalStance
    case causes
    case livingSituation
    case musicPreferences
    case goingOut
    case stayingIn
    case fanFavourites
    case socialMedia
    case moviePreferences
    case travel
    case outdoorActivities
    case gaming
    case threeThings
    case searchBio
    case photoUpload
    case idVerification
    case blockedContacts
    case subscriptionPaywall
    case completed

    var helpTitle: String {
        switch self {
        case .locationPermission:
            return "Location Permission"
        case .gender:
            return "Gender"
        case .orientation:
            return "Orientation"
        case .interestedIn:
            return "Interested In"
        case .relationship:
            return "Relationship"
        case .distancePreference:
            return "Distance Preference"
        case .height:
            return "Height"
        case .education:
            return "Education"
        case .employment:
            return "Employment"
        case .industry:
            return "Industry"
        case .school:
            return "School"
        case .drinking:
            return "Drinking"
        case .favouriteDrink:
            return "Favourite Drink"
        case .workout:
            return "Workout"
        case .smoking:
            return "Smoking"
        case .religion:
            return "Religion"
        case .kidsPreference:
            return "Kids Preference"
        case .cultural:
            return "Cultural"
        case .favourites:
            return "Favourites"
        case .personalBackground:
            return "Personal Background"
        case .appearanceStyle:
            return "Appearance Style"
        case .personality:
            return "Personality"
        case .hobbiesInterests:
            return "Hobbies & Interests"
        case .dateNight:
            return "Date Night"
        case .lifestyle:
            return "Lifestyle"
        case .pets:
            return "Pets"
        case .sports:
            return "Sports"
        case .hobbies:
            return "Hobbies"
        case .politicalStance:
            return "Political Stance"
        case .causes:
            return "Causes"
        case .livingSituation:
            return "Living Situation"
        case .musicPreferences:
            return "Music Preferences"
        case .goingOut:
            return "Going Out"
        case .stayingIn:
            return "Staying In"
        case .fanFavourites:
            return "Fan Favourites"
        case .socialMedia:
            return "Social Media"
        case .moviePreferences:
            return "Movie Preferences"
        case .travel:
            return "Travel"
        case .outdoorActivities:
            return "Outdoor Activities"
        case .gaming:
            return "Gaming"
        case .threeThings:
            return "Three Things"
        case .searchBio:
            return "Search Bio"
        case .photoUpload:
            return "Photo Upload"
        case .idVerification:
            return "ID Verification"
        case .blockedContacts:
            return "Blocked Contacts"
        case .subscriptionPaywall:
            return "Subscription Paywall"
        case .completed:
            return "Completed"
        }
    }

    var helpDescription: String {
        switch self {
        case .locationPermission:
            return "Provide access to your location."
        case .gender:
            return "Select your gender."
        case .orientation:
            return "Select your sexual orientation."
        case .interestedIn:
            return "Select who you are interested in."
        case .relationship:
            return "Define your relationship status."
        case .distancePreference:
            return "Set your distance preference for matches."
        case .height:
            return "Specify your height."
        case .education:
            return "Select your education level."
        case .employment:
            return "Select your employment status."
        case .industry:
            return "Choose your industry."
        case .school:
            return "Select your school."
        case .drinking:
            return "Specify your drinking habits."
        case .favouriteDrink:
            return "Select your favourite drink."
        case .workout:
            return "Specify your workout habits."
        case .smoking:
            return "Specify your smoking habits."
        case .religion:
            return "Select your religion."
        case .kidsPreference:
            return "Specify your preference for kids."
        case .cultural:
            return "Select your cultural background."
        case .favourites:
            return "Select your favourite things."
        case .personalBackground:
            return "Share your personal background."
        case .appearanceStyle:
            return "Select your appearance style."
        case .personality:
            return "Describe your personality."
        case .hobbiesInterests:
            return "Share your hobbies and interests."
        case .dateNight:
            return "Describe your ideal date night."
        case .lifestyle:
            return "Describe your lifestyle."
        case .pets:
            return "Specify your pet preferences."
        case .sports:
            return "Select your sports interests."
        case .hobbies:
            return "Describe your hobbies."
        case .politicalStance:
            return "Share your political stance."
        case .causes:
            return "Select causes you care about."
        case .livingSituation:
            return "Describe your living situation."
        case .musicPreferences:
            return "Share your music preferences."
        case .goingOut:
            return "Describe your going out preferences."
        case .stayingIn:
            return "Describe your staying in preferences."
        case .fanFavourites:
            return "Select your fan favourites."
        case .socialMedia:
            return "Share your social media usage."
        case .moviePreferences:
            return "Share your movie preferences."
        case .travel:
            return "Describe your travel preferences."
        case .outdoorActivities:
            return "Select your outdoor activities."
        case .gaming:
            return "Share your gaming preferences."
        case .threeThings:
            return "Share three things about yourself."
        case .searchBio:
            return "Write a short bio for search."
        case .photoUpload:
            return "Upload your photo."
        case .idVerification:
            return "Verify your identity."
        case .blockedContacts:
            return "Manage your blocked contacts."
        case .subscriptionPaywall:
            return "Manage your subscription preferences."
        case .completed:
            return "You have completed the onboarding."
        }
    }

    func next() -> OnboardingStep? {
        // Logic to get the next step
    }

    func previous() -> OnboardingStep? {
        // Logic to get the previous step
    }

    func advance() {
        // Logic to advance to the next step
    }

    func back() {
        // Logic to go back to the previous step
    }
}