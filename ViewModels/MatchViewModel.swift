import Foundation
import SwiftUI

class MatchViewModel: ObservableObject {
    @Published var potentialMatches: [User] = []
    @Published var currentMatches: [Match] = []
    @Published var currentUser: User?
    @Published var isLoading = false
    @Published var showMatchAnimation = false
    @Published var newMatch: Match?
    
    private let matchService = MatchService.shared
    
    func loadPotentialMatches() async {
        await MainActor.run { isLoading = true }
        
        do {
            let matches = try await matchService.fetchPotentialMatches()
            await MainActor.run {
                potentialMatches = matches
                isLoading = false
            }
        } catch {
            print("Error loading matches: \(error)")
            await MainActor.run { isLoading = false }
        }
    }
    
    func swipeLeft(on user: User) async {
        do {
            _ = try await matchService.swipe(on: user.id, action: .dislike)
            await MainActor.run {
                potentialMatches.removeAll { $0.id == user.id }
            }
        } catch {
            print("Error swiping: \(error)")
        }
    }
    
    func swipeRight(on user: User) async {
        do {
            if let match = try await matchService.swipe(on: user.id, action: .like) {
                await MainActor.run {
                    potentialMatches.removeAll { $0.id == user.id }
                    newMatch = match
                    showMatchAnimation = true
                }
            } else {
                await MainActor.run {
                    potentialMatches.removeAll { $0.id == user.id }
                }
            }
        } catch {
            print("Error swiping: \(error)")
        }
    }
    
    func superLike(on user: User) async {
        do {
            if let match = try await matchService.swipe(on: user.id, action: .superLike) {
                await MainActor.run {
                    potentialMatches.removeAll { $0.id == user.id }
                    newMatch = match
                    showMatchAnimation = true
                }
            } else {
                await MainActor.run {
                    potentialMatches.removeAll { $0.id == user.id }
                }
            }
        } catch {
            print("Error swiping: \(error)")
        }
    }
    
    func loadMatches() async {
        do {
            let matches = try await matchService.fetchMatches()
            await MainActor.run {
                currentMatches = matches
            }
        } catch {
            print("Error loading matches: \(error)")
        }
    }
}
