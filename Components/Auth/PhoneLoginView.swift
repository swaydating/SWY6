import SwiftUI

struct PhoneLoginView: View {
    @StateObject private var viewModel = AuthViewModel()
    @State private var showVerification = false
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack(spacing: 24) {
            if !showVerification {
                phoneNumberStep
            } else {
                verificationStep
            }
        }
        .padding(.horizontal, 24)
        .navigationTitle("Phone Sign In")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    private var phoneNumberStep: some View {
        VStack(spacing: 24) {
            Image(systemName: "phone.fill")
                .font(.system(size: 60))
                .foregroundColor(.blue)
                .padding(.top, 40)
            
            Text("Enter your phone number")
                .font(.title2.bold())
            
            Text("We'll send you a verification code")
                .font(.subheadline)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
                .padding(.bottom, 20)
            
            CustomTextField(
                placeholder: "Phone Number",
                text: $viewModel.phoneNumber,
                keyboardType: .phonePad
            )
            
            PrimaryButton(
                title: "Send Code",
                action: {
                    Task {
                        await viewModel.signInWithPhone()
                        showVerification = true
                    }
                },
                isLoading: viewModel.isLoading,
                isDisabled: !viewModel.isPhoneValid
            )
            
            Spacer()
        }
    }
    
    private var verificationStep: some View {
        VStack(spacing: 24) {
            Image(systemName: "checkmark.shield.fill")
                .font(.system(size: 60))
                .foregroundColor(.green)
                .padding(.top, 40)
            
            Text("Enter verification code")
                .font(.title2.bold())
            
            Text("Sent to \(viewModel.phoneNumber)")
                .font(.subheadline)
                .foregroundColor(.secondary)
                .padding(.bottom, 20)
            
            CustomTextField(
                placeholder: "6-digit code",
                text: $viewModel.verificationCode,
                keyboardType: .numberPad
            )
            
            PrimaryButton(
                title: "Verify",
                action: {
                    Task {
                        await viewModel.verifyCode()
                    }
                },
                isLoading: viewModel.isLoading,
                isDisabled: viewModel.verificationCode.count != 6
            )
            
            Button("Resend Code") {
                Task {
                    await viewModel.signInWithPhone()
                }
            }
            .foregroundColor(.blue)
            .padding(.top, 8)
            
            Spacer()
        }
    }
}
