import SwiftUI

struct MatchingView: View {
    @StateObject private var viewModel = MatchViewModel()
    
    var body: some View {
        ZStack {
            Color(.systemBackground).ignoresSafeArea()
            
            if viewModel.isLoading {
                LoadingView()
            } else if viewModel.potentialMatches.isEmpty {
                EmptyMatchesView()
            } else {
                VStack {
                    // Header
                    HStack {
                        Image(systemName: "heart.fill")
                            .font(.title2)
                            .foregroundColor(.pink)
                        Text("Sway")
                            .font(.title.bold())
                        Spacer()
                        Button(action: {}) {
                            Image(systemName: "slider.horizontal.3")
                                .font(.title2)
                                .foregroundColor(.primary)
                        }
                    }
                    .padding()
                    
                    // Card Stack
                    ZStack {
                        ForEach(viewModel.potentialMatches.prefix(3).reversed()) { user in
                            UserCardView(user: user)
                                .zIndex(user.id == viewModel.potentialMatches.first?.id ? 1 : 0)
                        }
                    }
                    .padding(.horizontal)
                    
                    // Action Buttons
                    HStack(spacing: 20) {
                        ActionButton(icon: "xmark", color: .red) {
                            if let user = viewModel.potentialMatches.first {
                                Task {
                                    await viewModel.swipeLeft(on: user)
                                }
                            }
                        }
                        
                        ActionButton(icon: "star.fill", color: .blue, size: 50) {
                            if let user = viewModel.potentialMatches.first {
                                Task {
                                    await viewModel.superLike(on: user)
                                }
                            }
                        }
                        
                        ActionButton(icon: "heart.fill", color: .green) {
                            if let user = viewModel.potentialMatches.first {
                                Task {
                                    await viewModel.swipeRight(on: user)
                                }
                            }
                        }
                    }
                    .padding()
                }
            }
            
            // Match Animation
            if viewModel.showMatchAnimation, let match = viewModel.newMatch {
                MatchAnimationView(match: match, isShowing: $viewModel.showMatchAnimation)
            }
        }
        .task {
            await viewModel.loadPotentialMatches()
        }
    }
}

struct UserCardView: View {
    let user: User
    @State private var offset = CGSize.zero
    @State private var color: Color = .clear
    
    var body: some View {
        ZStack(alignment: .bottom) {
            // Background Image
            Rectangle()
                .fill(
                    LinearGradient(
                        colors: [.blue.opacity(0.3), .purple.opacity(0.3)],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
            
            // User Info
            VStack(alignment: .leading, spacing: 8) {
                HStack {
                    Text(user.firstName)
                        .font(.title.bold())
                        .foregroundColor(.white)
                    
                    if let age = user.dateOfBirth?.age {
                        Text("\(age)")
                            .font(.title)
                            .foregroundColor(.white)
                    }
                    
                    if user.isVerified {
                        Image(systemName: "checkmark.seal.fill")
                            .foregroundColor(.blue)
                    }
                }
                
                if let bio = user.bio {
                    Text(bio)
                        .font(.body)
                        .foregroundColor(.white)
                        .lineLimit(2)
                }
                
                HStack {
                    ForEach(user.interests.prefix(3), id: \.self) { interest in
                        Text(interest)
                            .font(.caption)
                            .padding(.horizontal, 12)
                            .padding(.vertical, 6)
                            .background(Color.white.opacity(0.3))
                            .foregroundColor(.white)
                            .cornerRadius(12)
                    }
                }
            }
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(
                LinearGradient(
                    colors: [.clear, .black.opacity(0.8)],
                    startPoint: .top,
                    endPoint: .bottom
                )
            )
        }
        .frame(height: 500)
        .cornerRadius(20)
        .shadow(radius: 10)
        .offset(offset)
        .rotationEffect(.degrees(Double(offset.width / 20)))
        .gesture(
            DragGesture()
                .onChanged { gesture in
                    offset = gesture.translation
                    if offset.width > 0 {
                        color = .green
                    } else {
                        color = .red
                    }
                }
                .onEnded { _ in
                    withAnimation {
                        if abs(offset.width) > 100 {
                            offset = CGSize(width: offset.width * 10, height: 0)
                        } else {
                            offset = .zero
                            color = .clear
                        }
                    }
                }
        )
    }
}

struct ActionButton: View {
    let icon: String
    let color: Color
    var size: CGFloat = 60
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Image(systemName: icon)
                .font(.system(size: size * 0.4))
                .foregroundColor(color)
                .frame(width: size, height: size)
                .background(Color.white)
                .clipShape(Circle())
                .shadow(radius: 4)
        }
    }
}

struct EmptyMatchesView: View {
    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "person.2.slash")
                .font(.system(size: 80))
                .foregroundColor(.gray)
            
            Text("No more profiles")
                .font(.title2.bold())
            
            Text("Check back later for new matches")
                .font(.body)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
        }
        .padding()
    }
}

struct MatchAnimationView: View {
    let match: Match
    @Binding var isShowing: Bool
    
    var body: some View {
        ZStack {
            Color.black.opacity(0.8)
                .ignoresSafeArea()
                .onTapGesture {
                    isShowing = false
                }
            
            VStack(spacing: 30) {
                Text("It's a Match!")
                    .font(.system(size: 48, weight: .bold))
                    .foregroundColor(.white)
                
                Image(systemName: "heart.fill")
                    .font(.system(size: 100))
                    .foregroundColor(.pink)
                
                Button(action: { isShowing = false }) {
                    Text("Keep Swiping")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: 54)
                        .background(Color.blue)
                        .cornerRadius(27)
                }
                .padding(.horizontal, 40)
            }
        }
    }
}

extension Date {
    var age: Int {
        Calendar.current.dateComponents([.year], from: self, to: Date()).year ?? 0
    }
}
