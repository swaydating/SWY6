import SwiftUI

struct WelcomeStepView: View {
    @ObservedObject var viewModel: OnboardingViewModel
    
    var body: some View {
        VStack(spacing: 30) {
            Spacer()
            
            Image(systemName: "heart.circle.fill")
                .font(.system(size: 120))
                .foregroundColor(.pink)
            
            Text("Welcome to Sway")
                .font(.system(size: 36, weight: .bold))
            
            Text("Let's set up your profile")
                .font(.title3)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 40)
            
            VStack(alignment: .leading, spacing: 12) {
                FeatureRow(icon: "checkmark.circle.fill", text: "Find your perfect match")
                FeatureRow(icon: "lock.shield.fill", text: "Safe and verified profiles")
                FeatureRow(icon: "message.fill", text: "Connect and chat instantly")
                FeatureRow(icon: "sparkles", text: "Smart matching algorithm")
            }
            .padding(.horizontal, 40)
            .padding(.vertical, 20)
            
            Spacer()
        }
    }
}

struct FeatureRow: View {
    let icon: String
    let text: String
    
    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: icon)
                .foregroundColor(.blue)
                .font(.title3)
            Text(text)
                .font(.body)
        }
    }
}
