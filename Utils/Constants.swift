import Foundation

class Constants {
    // API Configuration
    struct API {
        static let baseURL = "https://api.sway.dating/v1"
        static let timeout: TimeInterval = 30
    }
    
    // App Configuration
    struct App {
        static let name = "Sway"
        static let version = "1.0.0"
        static let minimumAge = 18
        static let maximumPhotoCount = 6
        static let minimumPhotoCount = 2
        static let bioMinLength = 20
        static let bioMaxLength = 500
    }
    
    // Feature Flags
    struct Features {
        static let socialSignInEnabled = true
        static let idVerificationEnabled = true
        static let videoCallsEnabled = false
        static let voiceNotesEnabled = false
    }
    
    // UI Configuration
    struct UI {
        static let cornerRadius: CGFloat = 12
        static let buttonHeight: CGFloat = 54
        static let maxSwipeDistance: CGFloat = 200
    }
    
    // Matching Configuration
    struct Matching {
        static let maxDistance = 100 // miles
        static let defaultAgeRange = 18...99
        static let superLikesPerDay = 5
    }
}
