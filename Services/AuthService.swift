import Foundation
import Combine

class AuthService: ObservableObject {
    static let shared = AuthService()
    
    @Published var currentUser: User?
    @Published var isAuthenticated = false
    @Published var authState: AuthState = .unauthenticated
    
    enum AuthState {
        case unauthenticated
        case authenticating
        case authenticated
        case error(String)
    }
    
    private init() {}
    
    func signInWithEmail(email: String, password: String) async throws -> User {
        authState = .authenticating
        
        // Simulate API call
        try await Task.sleep(nanoseconds: 1_000_000_000)
        
        // Create mock user
        let user = User(
            id: UUID().uuidString,
            email: email,
            phoneNumber: nil,
            firstName: "",
            lastName: "",
            dateOfBirth: nil,
            gender: nil,
            profileImageURL: nil,
            bio: nil,
            location: nil,
            interests: [],
            photos: [],
            isVerified: false,
            onboardingCompleted: false,
            createdAt: Date(),
            updatedAt: Date()
        )
        
        await MainActor.run {
            self.currentUser = user
            self.isAuthenticated = true
            self.authState = .authenticated
        }
        
        return user
    }
    
    func signInWithPhone(phoneNumber: String, verificationCode: String) async throws -> User {
        authState = .authenticating
        
        try await Task.sleep(nanoseconds: 1_000_000_000)
        
        let user = User(
            id: UUID().uuidString,
            email: "",
            phoneNumber: phoneNumber,
            firstName: "",
            lastName: "",
            dateOfBirth: nil,
            gender: nil,
            profileImageURL: nil,
            bio: nil,
            location: nil,
            interests: [],
            photos: [],
            isVerified: false,
            onboardingCompleted: false,
            createdAt: Date(),
            updatedAt: Date()
        )
        
        await MainActor.run {
            self.currentUser = user
            self.isAuthenticated = true
            self.authState = .authenticated
        }
        
        return user
    }
    
    func signInWithApple(token: String) async throws -> User {
        authState = .authenticating
        try await Task.sleep(nanoseconds: 1_000_000_000)
        
        let user = User(
            id: UUID().uuidString,
            email: "apple@user.com",
            phoneNumber: nil,
            firstName: "",
            lastName: "",
            dateOfBirth: nil,
            gender: nil,
            profileImageURL: nil,
            bio: nil,
            location: nil,
            interests: [],
            photos: [],
            isVerified: false,
            onboardingCompleted: false,
            createdAt: Date(),
            updatedAt: Date()
        )
        
        await MainActor.run {
            self.currentUser = user
            self.isAuthenticated = true
            self.authState = .authenticated
        }
        
        return user
    }
    
    func signInWithGoogle(token: String) async throws -> User {
        authState = .authenticating
        try await Task.sleep(nanoseconds: 1_000_000_000)
        
        let user = User(
            id: UUID().uuidString,
            email: "google@user.com",
            phoneNumber: nil,
            firstName: "",
            lastName: "",
            dateOfBirth: nil,
            gender: nil,
            profileImageURL: nil,
            bio: nil,
            location: nil,
            interests: [],
            photos: [],
            isVerified: false,
            onboardingCompleted: false,
            createdAt: Date(),
            updatedAt: Date()
        )
        
        await MainActor.run {
            self.currentUser = user
            self.isAuthenticated = true
            self.authState = .authenticated
        }
        
        return user
    }
    
    func signOut() {
        currentUser = nil
        isAuthenticated = false
        authState = .unauthenticated
    }
    
    func sendVerificationCode(to phoneNumber: String) async throws {
        try await Task.sleep(nanoseconds: 500_000_000)
    }
    
    func verifyCode(_ code: String) async throws -> Bool {
        try await Task.sleep(nanoseconds: 500_000_000)
        return code.count == 6
    }
}
