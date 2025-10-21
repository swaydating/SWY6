import SwiftUI

struct ReviewProfileStepView: View {
    @ObservedObject var viewModel: OnboardingViewModel
    
    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                Image(systemName: "checkmark.circle.fill")
                    .font(.system(size: 80))
                    .foregroundColor(.green)
                    .padding(.top, 40)
                
                Text("Review Your Profile")
                    .font(.title.bold())
                
                Text("Make sure everything looks good")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                
                // Profile Preview Card
                VStack(alignment: .leading, spacing: 16) {
                    HStack {
                        Circle()
                            .fill(LinearGradient(
                                colors: [.blue, .purple],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            ))
                            .frame(width: 80, height: 80)
                            .overlay(
                                Text(viewModel.firstName.prefix(1))
                                    .font(.system(size: 32, weight: .bold))
                                    .foregroundColor(.white)
                            )
                        
                        VStack(alignment: .leading, spacing: 4) {
                            HStack {
                                Text("\(viewModel.firstName) \(viewModel.lastName)")
                                    .font(.title2.bold())
                                if let age = viewModel.dateOfBirth.age {
                                    Text("\(age)")
                                        .font(.title2)
                                }
                            }
                            if let gender = viewModel.selectedGender {
                                Text(gender.rawValue)
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                            }
                        }
                        Spacer()
                    }
                    
                    if !viewModel.bio.isEmpty {
                        VStack(alignment: .leading, spacing: 4) {
                            Text("About")
                                .font(.headline)
                            Text(viewModel.bio)
                                .font(.body)
                                .foregroundColor(.secondary)
                        }
                    }
                    
                    if !viewModel.selectedInterests.isEmpty {
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Interests")
                                .font(.headline)
                            FlowLayout(spacing: 8) {
                                ForEach(viewModel.selectedInterests, id: \.self) { interest in
                                    Text(interest)
                                        .font(.caption)
                                        .padding(.horizontal, 12)
                                        .padding(.vertical, 6)
                                        .background(Color.blue.opacity(0.1))
                                        .foregroundColor(.blue)
                                        .cornerRadius(12)
                                }
                            }
                        }
                    }
                    
                    if !viewModel.photos.isEmpty {
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Photos (\(viewModel.photos.count))")
                                .font(.headline)
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack(spacing: 12) {
                                    ForEach(viewModel.photos.indices, id: \.self) { index in
                                        Image(uiImage: viewModel.photos[index])
                                            .resizable()
                                            .scaledToFill()
                                            .frame(width: 100, height: 100)
                                            .clipped()
                                            .cornerRadius(8)
                                    }
                                }
                            }
                        }
                    }
                }
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(16)
                .padding(.horizontal)
                
                Text("Tap 'Next' to continue or go back to edit")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
        }
    }
}

struct NotificationsStepView: View {
    @ObservedObject var viewModel: OnboardingViewModel
    @State private var pushNotifications = true
    @State private var emailNotifications = true
    @State private var matchNotifications = true
    @State private var messageNotifications = true
    
    var body: some View {
        VStack(spacing: 24) {
            Spacer()
            
            Image(systemName: "bell.badge.fill")
                .font(.system(size: 80))
                .foregroundColor(.orange)
            
            Text("Stay Updated")
                .font(.title.bold())
            
            Text("Choose how you want to be notified")
                .font(.body)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 40)
            
            VStack(spacing: 16) {
                NotificationToggleRow(
                    icon: "app.badge.fill",
                    title: "Push Notifications",
                    description: "Get notified on your device",
                    isOn: $pushNotifications
                )
                
                NotificationToggleRow(
                    icon: "envelope.fill",
                    title: "Email Notifications",
                    description: "Receive updates via email",
                    isOn: $emailNotifications
                )
                
                NotificationToggleRow(
                    icon: "heart.fill",
                    title: "New Matches",
                    description: "When you get a new match",
                    isOn: $matchNotifications
                )
                
                NotificationToggleRow(
                    icon: "message.fill",
                    title: "Messages",
                    description: "When you receive messages",
                    isOn: $messageNotifications
                )
            }
            .padding(.horizontal, 24)
            
            Text("You can change these later in Settings")
                .font(.caption)
                .foregroundColor(.secondary)
            
            Spacer()
        }
    }
}

struct NotificationToggleRow: View {
    let icon: String
    let title: String
    let description: String
    @Binding var isOn: Bool
    
    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: icon)
                .font(.title2)
                .foregroundColor(.blue)
                .frame(width: 30)
            
            VStack(alignment: .leading, spacing: 2) {
                Text(title)
                    .font(.headline)
                Text(description)
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            
            Spacer()
            
            Toggle("", isOn: $isOn)
                .labelsHidden()
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(12)
    }
}

struct TermsStepView: View {
    @ObservedObject var viewModel: OnboardingViewModel
    @State private var agreedToTerms = false
    @State private var agreedToPrivacy = false
    
    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                Image(systemName: "doc.text.fill")
                    .font(.system(size: 80))
                    .foregroundColor(.blue)
                    .padding(.top, 40)
                
                Text("Terms & Conditions")
                    .font(.title.bold())
                
                Text("Please read and accept")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                
                VStack(alignment: .leading, spacing: 16) {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Key Points:")
                            .font(.headline)
                        
                        BulletPoint(text: "You must be 18 or older to use Sway")
                        BulletPoint(text: "Be respectful to all users")
                        BulletPoint(text: "Don't share personal information publicly")
                        BulletPoint(text: "Report any suspicious activity")
                        BulletPoint(text: "Your data is secure and encrypted")
                    }
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(12)
                    
                    Toggle(isOn: $agreedToTerms) {
                        VStack(alignment: .leading, spacing: 4) {
                            Text("I agree to the Terms of Service")
                                .font(.subheadline)
                            Button(action: {}) {
                                Text("Read full terms")
                                    .font(.caption)
                                    .foregroundColor(.blue)
                            }
                        }
                    }
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(12)
                    
                    Toggle(isOn: $agreedToPrivacy) {
                        VStack(alignment: .leading, spacing: 4) {
                            Text("I agree to the Privacy Policy")
                                .font(.subheadline)
                            Button(action: {}) {
                                Text("Read full policy")
                                    .font(.caption)
                                    .foregroundColor(.blue)
                            }
                        }
                    }
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(12)
                }
                .padding(.horizontal, 24)
                
                if !agreedToTerms || !agreedToPrivacy {
                    Text("You must accept both to continue")
                        .font(.caption)
                        .foregroundColor(.red)
                }
            }
        }
    }
}

struct BulletPoint: View {
    let text: String
    
    var body: some View {
        HStack(alignment: .top, spacing: 8) {
            Text("•")
                .font(.body)
            Text(text)
                .font(.subheadline)
        }
    }
}

struct FlowLayout: Layout {
    var spacing: CGFloat = 8
    
    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) -> CGSize {
        let result = FlowResult(in: proposal.replacingUnspecifiedDimensions().width, subviews: subviews, spacing: spacing)
        return result.size
    }
    
    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) {
        let result = FlowResult(in: bounds.width, subviews: subviews, spacing: spacing)
        for (index, subview) in subviews.enumerated() {
            subview.place(at: CGPoint(x: bounds.minX + result.positions[index].x, y: bounds.minY + result.positions[index].y), proposal: .unspecified)
        }
    }
    
    struct FlowResult {
        var size: CGSize = .zero
        var positions: [CGPoint] = []
        
        init(in maxWidth: CGFloat, subviews: Subviews, spacing: CGFloat) {
            var x: CGFloat = 0
            var y: CGFloat = 0
            var lineHeight: CGFloat = 0
            
            for subview in subviews {
                let size = subview.sizeThatFits(.unspecified)
                
                if x + size.width > maxWidth && x > 0 {
                    x = 0
                    y += lineHeight + spacing
                    lineHeight = 0
                }
                
                positions.append(CGPoint(x: x, y: y))
                lineHeight = max(lineHeight, size.height)
                x += size.width + spacing
            }
            
            self.size = CGSize(width: maxWidth, height: y + lineHeight)
        }
    }
}
