import Foundation
import SwiftUI

class ChatViewModel: ObservableObject {
    @Published var conversations: [Conversation] = []
    @Published var currentConversation: Conversation?
    @Published var messages: [Message] = []
    @Published var messageText = ""
    @Published var isLoading = false
    
    private let messageService = MessageService.shared
    
    func loadConversations() async {
        await MainActor.run { isLoading = true }
        
        do {
            let convos = try await messageService.fetchConversations()
            await MainActor.run {
                conversations = convos
                isLoading = false
            }
        } catch {
            print("Error loading conversations: \(error)")
            await MainActor.run { isLoading = false }
        }
    }
    
    func loadMessages(for matchId: String) async {
        await MainActor.run { isLoading = true }
        
        do {
            let msgs = try await messageService.fetchMessages(for: matchId)
            await MainActor.run {
                messages = msgs
                isLoading = false
            }
        } catch {
            print("Error loading messages: \(error)")
            await MainActor.run { isLoading = false }
        }
    }
    
    func sendMessage() async {
        guard !messageText.isEmpty else { return }
        
        let text = messageText
        await MainActor.run { messageText = "" }
        
        do {
            if let matchId = currentConversation?.id {
                let message = try await messageService.sendMessage(text, to: matchId)
                await MainActor.run {
                    messages.append(message)
                }
            }
        } catch {
            print("Error sending message: \(error)")
        }
    }
}
