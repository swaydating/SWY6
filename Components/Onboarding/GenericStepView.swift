import SwiftUI

struct GenericStepView: View {
    let step: OnboardingStep
    @ObservedObject var viewModel: OnboardingViewModel
    
    var body: some View {
        VStack(spacing: 24) {
            Spacer()
            
            Image(systemName: iconForStep)
                .font(.system(size: 60))
                .foregroundColor(.blue)
            
            Text(step.title)
                .font(.title.bold())
                .multilineTextAlignment(.center)
            
            Text("This step is coming soon")
                .font(.body)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 40)
            
            Spacer()
        }
    }
    
    private var iconForStep: String {
        switch step {
        case .height: return "ruler"
        case .ethnicity: return "person.2"
        case .bodyType: return "figure.walk"
        case .education: return "graduationcap.fill"
        case .occupation: return "briefcase.fill"
        case .smoking: return "smoke.fill"
        case .drinking: return "wineglass.fill"
        case .exercise: return "dumbbell.fill"
        case .pets: return "pawprint.fill"
        case .children: return "figure.and.child.holdinghands"
        case .religion: return "book.closed.fill"
        case .idVerification: return "checkmark.shield.fill"
        case .notifications: return "bell.fill"
        case .terms: return "doc.text.fill"
        default: return "questionmark.circle"
        }
    }
}
