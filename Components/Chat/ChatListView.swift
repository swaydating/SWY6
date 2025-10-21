import SwiftUI

struct ChatListView: View {
    @StateObject private var viewModel = ChatViewModel()
    
    var body: some View {
        NavigationView {
            ZStack {
                if viewModel.isLoading {
                    LoadingView()
                } else if viewModel.conversations.isEmpty {
                    EmptyChatsView()
                } else {
                    List {
                        ForEach(viewModel.conversations) { conversation in
                            NavigationLink(destination: ChatDetailView(conversation: conversation)) {
                                ChatRowView(conversation: conversation)
                            }
                        }
                    }
                    .listStyle(.plain)
                }
            }
            .navigationTitle("Messages")
            .task {
                await viewModel.loadConversations()
            }
        }
    }
}

struct ChatRowView: View {
    let conversation: Conversation
    
    var body: some View {
        HStack(spacing: 12) {
            // Profile Image
            Circle()
                .fill(LinearGradient(
                    colors: [.blue, .purple],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                ))
                .frame(width: 60, height: 60)
                .overlay(
                    Text(conversation.match.matchedUser?.firstName.prefix(1) ?? "?")
                        .font(.title2.bold())
                        .foregroundColor(.white)
                )
            
            VStack(alignment: .leading, spacing: 4) {
                HStack {
                    Text(conversation.match.matchedUser?.firstName ?? "Unknown")
                        .font(.headline)
                    
                    Spacer()
                    
                    if let lastMessage = conversation.messages.last {
                        Text(lastMessage.timestamp, style: .relative)
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                }
                
                if let lastMessage = conversation.messages.last {
                    Text(lastMessage.content)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        .lineLimit(1)
                }
                
                if conversation.unreadCount > 0 {
                    Text("\(conversation.unreadCount) unread")
                        .font(.caption)
                        .foregroundColor(.blue)
                }
            }
        }
        .padding(.vertical, 4)
    }
}

struct EmptyChatsView: View {
    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "message.circle")
                .font(.system(size: 80))
                .foregroundColor(.gray)
            
            Text("No messages yet")
                .font(.title2.bold())
            
            Text("Start matching to begin conversations")
                .font(.body)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
        }
        .padding()
    }
}
