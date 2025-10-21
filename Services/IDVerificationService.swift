import Foundation
import UIKit

class IDVerificationService: ObservableObject {
    static let shared = IDVerificationService()
    
    @Published var verificationStatus: VerificationStatus = .notStarted
    
    enum VerificationStatus {
        case notStarted
        case inProgress
        case pendingReview
        case verified
        case rejected(String)
    }
    
    private init() {}
    
    func uploadIDDocument(_ image: UIImage, documentType: DocumentType) async throws {
        verificationStatus = .inProgress
        
        try await Task.sleep(nanoseconds: 2_000_000_000)
        
        await MainActor.run {
            verificationStatus = .pendingReview
        }
    }
    
    func uploadSelfie(_ image: UIImage) async throws {
        try await Task.sleep(nanoseconds: 2_000_000_000)
        
        await MainActor.run {
            verificationStatus = .verified
        }
    }
    
    func checkVerificationStatus() async throws -> VerificationStatus {
        try await Task.sleep(nanoseconds: 500_000_000)
        return verificationStatus
    }
    
    enum DocumentType: String, CaseIterable {
        case driversLicense = "Driver's License"
        case passport = "Passport"
        case nationalID = "National ID"
        case other = "Other"
    }
}
