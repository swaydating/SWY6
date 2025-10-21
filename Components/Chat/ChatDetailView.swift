import SwiftUI

struct ChatDetailView: View {
    let conversation: Conversation
    @StateObject private var viewModel = ChatViewModel()
    @State private var scrollProxy: ScrollViewProxy? = nil
    
    var body: some View {
        VStack(spacing: 0) {
            ScrollViewReader { proxy in
                ScrollView {
                    LazyVStack(spacing: 12) {
                        ForEach(viewModel.messages) { message in
                            MessageBubble(message: message)
                                .id(message.id)
                        }
                    }
                    .padding()
                }
                .onAppear {
                    scrollProxy = proxy
                }
            }
            
            // Message Input
            HStack(spacing: 12) {
                TextField("Type a message...", text: $viewModel.messageText)
                    .padding(12)
                    .background(Color(.systemGray6))
                    .cornerRadius(20)
                
                Button(action: {
                    Task {
                        await viewModel.sendMessage()
                        scrollToBottom()
                    }
                }) {
                    Image(systemName: "arrow.up.circle.fill")
                        .font(.system(size: 36))
                        .foregroundColor(viewModel.messageText.isEmpty ? .gray : .blue)
                }
                .disabled(viewModel.messageText.isEmpty)
            }
            .padding()
            .background(Color(.systemBackground))
        }
        .navigationTitle(conversation.match.matchedUser?.firstName ?? "Chat")
        .navigationBarTitleDisplayMode(.inline)
        .task {
            viewModel.currentConversation = conversation
            await viewModel.loadMessages(for: conversation.id)
        }
    }
    
    private func scrollToBottom() {
        if let lastMessage = viewModel.messages.last {
            scrollProxy?.scrollTo(lastMessage.id, anchor: .bottom)
        }
    }
}

struct MessageBubble: View {
    let message: Message
    private let currentUserId = AuthService.shared.currentUser?.id ?? ""
    
    var isCurrentUser: Bool {
        message.senderId == currentUserId
    }
    
    var body: some View {
        HStack {
            if isCurrentUser {
                Spacer()
            }
            
            VStack(alignment: isCurrentUser ? .trailing : .leading, spacing: 4) {
                Text(message.content)
                    .padding(12)
                    .background(isCurrentUser ? Color.blue : Color(.systemGray5))
                    .foregroundColor(isCurrentUser ? .white : .primary)
                    .cornerRadius(16)
                
                Text(message.timestamp, style: .time)
                    .font(.caption2)
                    .foregroundColor(.secondary)
            }
            
            if !isCurrentUser {
                Spacer()
            }
        }
    }
}
