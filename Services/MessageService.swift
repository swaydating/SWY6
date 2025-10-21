import Foundation
import Combine

class MessageService: ObservableObject {
    static let shared = MessageService()
    
    @Published var conversations: [Conversation] = []
    
    private init() {}
    
    func fetchConversations() async throws -> [Conversation] {
        try await Task.sleep(nanoseconds: 1_000_000_000)
        return conversations
    }
    
    func fetchMessages(for matchId: String) async throws -> [Message] {
        try await Task.sleep(nanoseconds: 500_000_000)
        
        let conversation = conversations.first { $0.id == matchId }
        return conversation?.messages ?? []
    }
    
    func sendMessage(_ content: String, to matchId: String) async throws -> Message {
        try await Task.sleep(nanoseconds: 500_000_000)
        
        let message = Message(
            id: UUID().uuidString,
            matchId: matchId,
            senderId: AuthService.shared.currentUser?.id ?? "",
            receiverId: "",
            content: content,
            timestamp: Date(),
            isRead: false,
            messageType: .text
        )
        
        await MainActor.run {
            if let index = conversations.firstIndex(where: { $0.id == matchId }) {
                conversations[index].messages.append(message)
            }
        }
        
        return message
    }
    
    func markAsRead(messageId: String) async throws {
        try await Task.sleep(nanoseconds: 200_000_000)
        
        await MainActor.run {
            for i in 0..<conversations.count {
                if let msgIndex = conversations[i].messages.firstIndex(where: { $0.id == messageId }) {
                    conversations[i].messages[msgIndex].isRead = true
                }
            }
        }
    }
}
