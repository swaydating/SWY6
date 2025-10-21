import Foundation

struct Message: Identifiable, Codable {
    let id: String
    let matchId: String
    let senderId: String
    let receiverId: String
    let content: String
    let timestamp: Date
    var isRead: Bool
    var messageType: MessageType
    
    enum MessageType: String, Codable {
        case text
        case image
        case gif
    }
}

struct Conversation: Identifiable {
    let id: String
    let match: Match
    var messages: [Message]
    var unreadCount: Int
}
