import Foundation
import SwiftUI

class OnboardingViewModel: ObservableObject {
    @Published var currentStep: OnboardingStep = .welcome
    @Published var completedSteps: Set<OnboardingStep> = []
    @Published var userData: [String: Any] = [:]
    
    // Form fields
    @Published var firstName = ""
    @Published var lastName = ""
    @Published var dateOfBirth = Date()
    @Published var selectedGender: User.Gender?
    @Published var bio = ""
    @Published var selectedInterests: [String] = []
    @Published var photos: [UIImage] = []
    
    var progress: Double {
        let totalSteps = Double(OnboardingStep.allCases.count)
        let completed = Double(completedSteps.count)
        return completed / totalSteps
    }
    
    var canProceed: Bool {
        switch currentStep {
        case .firstName:
            return !firstName.isEmpty
        case .lastName:
            return !lastName.isEmpty
        case .gender:
            return selectedGender != nil
        case .bio:
            return bio.count >= 20
        case .photos:
            return photos.count >= 2
        case .interests:
            return selectedInterests.count >= 3
        default:
            return true
        }
    }
    
    func nextStep() {
        guard canProceed else { return }
        
        completedSteps.insert(currentStep)
        
        if let nextIndex = OnboardingStep.allCases.firstIndex(of: currentStep)?.advanced(by: 1),
           nextIndex < OnboardingStep.allCases.count {
            currentStep = OnboardingStep.allCases[nextIndex]
        }
    }
    
    func previousStep() {
        if let prevIndex = OnboardingStep.allCases.firstIndex(of: currentStep)?.advanced(by: -1),
           prevIndex >= 0 {
            currentStep = OnboardingStep.allCases[prevIndex]
        }
    }
    
    func skipStep() {
        completedSteps.insert(currentStep)
        nextStep()
    }
    
    func completeOnboarding() async {
        // Save all user data
        await MainActor.run {
            if var user = AuthService.shared.currentUser {
                user.firstName = firstName
                user.lastName = lastName
                user.dateOfBirth = dateOfBirth
                user.gender = selectedGender
                user.bio = bio
                user.interests = selectedInterests
                user.onboardingCompleted = true
                AuthService.shared.currentUser = user
            }
        }
    }
}
