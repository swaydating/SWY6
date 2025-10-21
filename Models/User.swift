import Foundation
import SwiftUI

struct User: Identifiable, Codable {
    let id: String
    var email: String
    var phoneNumber: String?
    var firstName: String
    var lastName: String
    var dateOfBirth: Date?
    var gender: Gender?
    var profileImageURL: String?
    var bio: String?
    var location: Location?
    var interests: [String]
    var photos: [String]
    var isVerified: Bool
    var onboardingCompleted: Bool
    var createdAt: Date
    var updatedAt: Date
    
    enum Gender: String, Codable, CaseIterable {
        case male = "Male"
        case female = "Female"
        case nonBinary = "Non-Binary"
        case other = "Other"
        case preferNotToSay = "Prefer not to say"
    }
}

struct Location: Codable {
    var latitude: Double
    var longitude: Double
    var city: String?
    var state: String?
    var country: String?
}
