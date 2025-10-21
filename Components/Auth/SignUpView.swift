import SwiftUI

struct SignUpView: View {
    @StateObject private var viewModel = AuthViewModel()
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                Image(systemName: "person.crop.circle.fill.badge.plus")
                    .font(.system(size: 80))
                    .foregroundColor(.blue)
                    .padding(.top, 40)
                
                Text("Create Account")
                    .font(.system(size: 32, weight: .bold))
                
                Text("Join Sway and find your match")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .padding(.bottom, 20)
                
                CustomTextField(
                    placeholder: "Email",
                    text: $viewModel.email,
                    keyboardType: .emailAddress,
                    autocapitalization: .never
                )
                
                CustomTextField(
                    placeholder: "Password",
                    text: $viewModel.password,
                    isSecure: true
                )
                
                CustomTextField(
                    placeholder: "Confirm Password",
                    text: $viewModel.confirmPassword,
                    isSecure: true
                )
                
                if !viewModel.password.isEmpty && !viewModel.passwordsMatch {
                    Text("Passwords don't match")
                        .font(.caption)
                        .foregroundColor(.red)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                
                PrimaryButton(
                    title: "Sign Up",
                    action: {
                        Task {
                            await viewModel.signInWithEmail()
                        }
                    },
                    isLoading: viewModel.isLoading,
                    isDisabled: !viewModel.isEmailValid || !viewModel.isPasswordValid || !viewModel.passwordsMatch
                )
                
                Text("OR")
                    .font(.caption)
                    .foregroundColor(.secondary)
                    .padding(.vertical, 8)
                
                SocialSignInButton(
                    title: "Sign up with Apple",
                    icon: "apple.logo",
                    backgroundColor: .black
                ) {
                    Task {
                        await viewModel.signInWithApple()
                    }
                }
                
                SocialSignInButton(
                    title: "Sign up with Google",
                    icon: "g.circle.fill",
                    backgroundColor: .white,
                    textColor: .black
                ) {
                    Task {
                        await viewModel.signInWithGoogle()
                    }
                }
                
                Spacer()
            }
            .padding(.horizontal, 24)
        }
        .navigationTitle("Sign Up")
        .navigationBarTitleDisplayMode(.inline)
        .alert("Error", isPresented: $viewModel.showError) {
            Button("OK", role: .cancel) { }
        } message: {
            Text(viewModel.errorMessage ?? "An error occurred")
        }
    }
}
