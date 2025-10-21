import Foundation
import Combine

class MatchService: ObservableObject {
    static let shared = MatchService()
    
    @Published var potentialMatches: [User] = []
    @Published var currentMatches: [Match] = []
    
    private init() {}
    
    func fetchPotentialMatches() async throws -> [User] {
        try await Task.sleep(nanoseconds: 1_000_000_000)
        
        // Mock users
        let mockUsers = (1...10).map { i in
            User(
                id: UUID().uuidString,
                email: "user\(i)@example.com",
                phoneNumber: nil,
                firstName: "User",
                lastName: "\(i)",
                dateOfBirth: Date().addingTimeInterval(-TimeInterval(25 * 365 * 24 * 60 * 60)),
                gender: i % 2 == 0 ? .male : .female,
                profileImageURL: nil,
                bio: "Hey there! I'm User \(i)",
                location: nil,
                interests: ["Travel", "Music", "Food"],
                photos: [],
                isVerified: i % 3 == 0,
                onboardingCompleted: true,
                createdAt: Date(),
                updatedAt: Date()
            )
        }
        
        await MainActor.run {
            self.potentialMatches = mockUsers
        }
        
        return mockUsers
    }
    
    func swipe(on userId: String, action: SwipeAction.Action) async throws -> Match? {
        try await Task.sleep(nanoseconds: 500_000_000)
        
        // Remove user from potential matches
        await MainActor.run {
            potentialMatches.removeAll { $0.id == userId }
        }
        
        // Check for match (50% chance for demo)
        if action == .like && Bool.random() {
            let match = Match(
                id: UUID().uuidString,
                userId: AuthService.shared.currentUser?.id ?? "",
                matchedUserId: userId,
                matchedUser: nil,
                matchedAt: Date(),
                isActive: true,
                lastMessageAt: nil
            )
            
            await MainActor.run {
                currentMatches.append(match)
            }
            
            return match
        }
        
        return nil
    }
    
    func fetchMatches() async throws -> [Match] {
        try await Task.sleep(nanoseconds: 1_000_000_000)
        return currentMatches
    }
    
    func unmatch(_ matchId: String) async throws {
        try await Task.sleep(nanoseconds: 500_000_000)
        
        await MainActor.run {
            currentMatches.removeAll { $0.id == matchId }
        }
    }
}
