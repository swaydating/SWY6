import SwiftUI

struct WalkthroughView: View {
    @State private var currentPage = 0
    @Binding var isPresented: Bool
    
    private let pages: [WalkthroughPage] = [
        WalkthroughPage(
            icon: "heart.fill",
            title: "Find Your Match",
            description: "Swipe through profiles and connect with people who share your interests",
            color: .pink
        ),
        WalkthroughPage(
            icon: "message.fill",
            title: "Start Conversations",
            description: "Match with someone? Start chatting right away and get to know each other",
            color: .blue
        ),
        WalkthroughPage(
            icon: "checkmark.shield.fill",
            title: "Stay Safe",
            description: "All profiles are verified. Report any suspicious activity to keep our community safe",
            color: .green
        ),
        WalkthroughPage(
            icon: "sparkles",
            title: "Smart Matching",
            description: "Our algorithm learns your preferences to show you the most compatible matches",
            color: .purple
        )
    ]
    
    var body: some View {
        ZStack {
            Color(.systemBackground).ignoresSafeArea()
            
            VStack(spacing: 0) {
                // Skip button
                HStack {
                    Spacer()
                    Button("Skip") {
                        isPresented = false
                    }
                    .foregroundColor(.blue)
                    .padding()
                }
                
                // Page View
                TabView(selection: $currentPage) {
                    ForEach(0..<pages.count, id: \.self) { index in
                        WalkthroughPageView(page: pages[index])
                            .tag(index)
                    }
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                
                // Page Indicator
                HStack(spacing: 8) {
                    ForEach(0..<pages.count, id: \.self) { index in
                        Circle()
                            .fill(index == currentPage ? Color.blue : Color.gray.opacity(0.3))
                            .frame(width: 8, height: 8)
                    }
                }
                .padding(.bottom, 20)
                
                // Continue/Get Started Button
                PrimaryButton(
                    title: currentPage == pages.count - 1 ? "Get Started" : "Continue"
                ) {
                    if currentPage == pages.count - 1 {
                        isPresented = false
                    } else {
                        withAnimation {
                            currentPage += 1
                        }
                    }
                }
                .padding(.horizontal)
                .padding(.bottom, 40)
            }
        }
    }
}

struct WalkthroughPage {
    let icon: String
    let title: String
    let description: String
    let color: Color
}

struct WalkthroughPageView: View {
    let page: WalkthroughPage
    
    var body: some View {
        VStack(spacing: 40) {
            Spacer()
            
            Image(systemName: page.icon)
                .font(.system(size: 100))
                .foregroundColor(page.color)
            
            VStack(spacing: 16) {
                Text(page.title)
                    .font(.system(size: 32, weight: .bold))
                    .multilineTextAlignment(.center)
                
                Text(page.description)
                    .font(.body)
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 40)
            }
            
            Spacer()
        }
    }
}
