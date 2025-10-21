import SwiftUI

struct LoginView: View {
    @StateObject private var viewModel = AuthViewModel()
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 24) {
                    // Logo
                    Image(systemName: "heart.fill")
                        .font(.system(size: 80))
                        .foregroundColor(.pink)
                        .padding(.top, 40)
                    
                    Text("Sway")
                        .font(.system(size: 48, weight: .bold))
                    
                    Text("Find your perfect match")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        .padding(.bottom, 40)
                    
                    // Email/Phone Toggle
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
                    
                    PrimaryButton(
                        title: "Sign In",
                        action: {
                            Task {
                                await viewModel.signInWithEmail()
                            }
                        },
                        isLoading: viewModel.isLoading,
                        isDisabled: !viewModel.isEmailValid || !viewModel.isPasswordValid
                    )
                    
                    Text("OR")
                        .font(.caption)
                        .foregroundColor(.secondary)
                        .padding(.vertical, 8)
                    
                    // Social Sign In
                    SocialSignInButton(
                        title: "Continue with Apple",
                        icon: "apple.logo",
                        backgroundColor: .black
                    ) {
                        Task {
                            await viewModel.signInWithApple()
                        }
                    }
                    
                    SocialSignInButton(
                        title: "Continue with Google",
                        icon: "g.circle.fill",
                        backgroundColor: .white,
                        textColor: .black
                    ) {
                        Task {
                            await viewModel.signInWithGoogle()
                        }
                    }
                    
                    NavigationLink("Sign in with Phone Number") {
                        PhoneLoginView()
                    }
                    .foregroundColor(.blue)
                    .padding(.top, 8)
                    
                    Spacer()
                    
                    NavigationLink("Don't have an account? Sign Up") {
                        SignUpView()
                    }
                    .foregroundColor(.blue)
                    .padding(.bottom, 20)
                }
                .padding(.horizontal, 24)
            }
            .alert("Error", isPresented: $viewModel.showError) {
                Button("OK", role: .cancel) { }
            } message: {
                Text(viewModel.errorMessage ?? "An error occurred")
            }
        }
    }
}

struct SocialSignInButton: View {
    let title: String
    let icon: String
    var backgroundColor: Color = .blue
    var textColor: Color = .white
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack {
                Image(systemName: icon)
                    .font(.title3)
                Text(title)
                    .font(.headline)
            }
            .foregroundColor(textColor)
            .frame(maxWidth: .infinity)
            .frame(height: 54)
            .background(backgroundColor)
            .cornerRadius(27)
            .overlay(
                RoundedRectangle(cornerRadius: 27)
                    .stroke(Color(.systemGray4), lineWidth: backgroundColor == .white ? 1 : 0)
            )
        }
    }
}
