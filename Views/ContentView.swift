import SwiftUI

struct ContentView: View {
    @ObservedObject private var authService = AuthService.shared
    @State private var showWalkthrough = true
    
    var body: some View {
        Group {
            if authService.isAuthenticated {
                if let user = authService.currentUser, !user.onboardingCompleted {
                    OnboardingContainerView()
                } else {
                    MainTabView()
                }
            } else {
                LoginView()
            }
        }
        .sheet(isPresented: $showWalkthrough) {
            WalkthroughView(isPresented: $showWalkthrough)
        }
    }
}
