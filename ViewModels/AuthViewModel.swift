import Foundation
import SwiftUI

class AuthViewModel: ObservableObject {
    @Published var email = ""
    @Published var phoneNumber = ""
    @Published var password = ""
    @Published var confirmPassword = ""
    @Published var verificationCode = ""
    @Published var isLoading = false
    @Published var errorMessage: String?
    @Published var showError = false
    
    private let authService = AuthService.shared
    
    var isEmailValid: Bool {
        email.contains("@") && email.contains(".")
    }
    
    var isPhoneValid: Bool {
        phoneNumber.count >= 10
    }
    
    var isPasswordValid: Bool {
        password.count >= 8
    }
    
    var passwordsMatch: Bool {
        password == confirmPassword && !password.isEmpty
    }
    
    func signInWithEmail() async {
        guard isEmailValid, isPasswordValid else {
            await showErrorMessage("Please enter valid credentials")
            return
        }
        
        await MainActor.run { isLoading = true }
        
        do {
            _ = try await authService.signInWithEmail(email: email, password: password)
        } catch {
            await showErrorMessage(error.localizedDescription)
        }
        
        await MainActor.run { isLoading = false }
    }
    
    func signInWithPhone() async {
        guard isPhoneValid else {
            await showErrorMessage("Please enter a valid phone number")
            return
        }
        
        await MainActor.run { isLoading = true }
        
        do {
            try await authService.sendVerificationCode(to: phoneNumber)
        } catch {
            await showErrorMessage(error.localizedDescription)
        }
        
        await MainActor.run { isLoading = false }
    }
    
    func verifyCode() async {
        guard verificationCode.count == 6 else {
            await showErrorMessage("Please enter a valid 6-digit code")
            return
        }
        
        await MainActor.run { isLoading = true }
        
        do {
            _ = try await authService.signInWithPhone(phoneNumber: phoneNumber, verificationCode: verificationCode)
        } catch {
            await showErrorMessage(error.localizedDescription)
        }
        
        await MainActor.run { isLoading = false }
    }
    
    func signInWithApple() async {
        await MainActor.run { isLoading = true }
        
        do {
            _ = try await authService.signInWithApple(token: "mock_token")
        } catch {
            await showErrorMessage(error.localizedDescription)
        }
        
        await MainActor.run { isLoading = false }
    }
    
    func signInWithGoogle() async {
        await MainActor.run { isLoading = true }
        
        do {
            _ = try await authService.signInWithGoogle(token: "mock_token")
        } catch {
            await showErrorMessage(error.localizedDescription)
        }
        
        await MainActor.run { isLoading = false }
    }
    
    private func showErrorMessage(_ message: String) async {
        await MainActor.run {
            errorMessage = message
            showError = true
        }
    }
}
