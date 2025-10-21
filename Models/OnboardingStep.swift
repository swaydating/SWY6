import Foundation

enum OnboardingStep: Int, CaseIterable {
    // Welcome & Basics
    case welcome = 0
    case phoneNumber
    case emailAddress
    case verificationCode
    case createPassword
    
    // Personal Info
    case firstName
    case lastName
    case dateOfBirth
    case gender
    case height
    case ethnicity
    case bodyType
    case hairColor
    case eyeColor
    
    // Location
    case location
    case locationPermission
    
    // Preferences
    case lookingFor
    case relationshipGoals
    case agePreference
    case distancePreference
    case genderPreference
    
    // Lifestyle
    case education
    case occupation
    case income
    case smoking
    case drinking
    case drugs
    case exercise
    case diet
    case pets
    case children
    case wantChildren
    case religion
    case politics
    
    // Interests & Hobbies
    case interests
    case hobbies
    case music
    case movies
    case books
    case sports
    
    // Profile
    case bio
    case photos
    case additionalPhotos
    case profileVideo
    
    // Verification
    case idVerification
    case photoVerification
    
    // Final
    case reviewProfile
    case notifications
    case terms
    case complete
    
    var title: String {
        switch self {
        case .welcome: return "Welcome to Sway"
        case .phoneNumber: return "Phone Number"
        case .emailAddress: return "Email Address"
        case .verificationCode: return "Verification Code"
        case .createPassword: return "Create Password"
        case .firstName: return "First Name"
        case .lastName: return "Last Name"
        case .dateOfBirth: return "Date of Birth"
        case .gender: return "Gender"
        case .height: return "Height"
        case .ethnicity: return "Ethnicity"
        case .bodyType: return "Body Type"
        case .hairColor: return "Hair Color"
        case .eyeColor: return "Eye Color"
        case .location: return "Location"
        case .locationPermission: return "Enable Location"
        case .lookingFor: return "I'm Looking For"
        case .relationshipGoals: return "Relationship Goals"
        case .agePreference: return "Age Range"
        case .distancePreference: return "Distance"
        case .genderPreference: return "Show Me"
        case .education: return "Education"
        case .occupation: return "Occupation"
        case .income: return "Income"
        case .smoking: return "Smoking"
        case .drinking: return "Drinking"
        case .drugs: return "Drugs"
        case .exercise: return "Exercise"
        case .diet: return "Diet"
        case .pets: return "Pets"
        case .children: return "Children"
        case .wantChildren: return "Want Children"
        case .religion: return "Religion"
        case .politics: return "Politics"
        case .interests: return "Interests"
        case .hobbies: return "Hobbies"
        case .music: return "Music"
        case .movies: return "Movies"
        case .books: return "Books"
        case .sports: return "Sports"
        case .bio: return "Bio"
        case .photos: return "Photos"
        case .additionalPhotos: return "More Photos"
        case .profileVideo: return "Profile Video"
        case .idVerification: return "ID Verification"
        case .photoVerification: return "Photo Verification"
        case .reviewProfile: return "Review Profile"
        case .notifications: return "Notifications"
        case .terms: return "Terms & Conditions"
        case .complete: return "All Set!"
        }
    }
}
