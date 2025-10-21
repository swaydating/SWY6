import Foundation

struct Match: Identifiable, Codable {
    let id: String
    let userId: String
    let matchedUserId: String
    var matchedUser: User?
    let matchedAt: Date
    var isActive: Bool
    var lastMessageAt: Date?
}

struct SwipeAction: Codable {
    let userId: String
    let targetUserId: String
    let action: Action
    let timestamp: Date
    
    enum Action: String, Codable {
        case like
        case dislike
        case superLike
    }
}
