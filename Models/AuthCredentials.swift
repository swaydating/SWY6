import Foundation

struct AuthCredentials {
    var email: String?
    var phoneNumber: String?
    var password: String?
    var verificationCode: String?
    var authProvider: AuthProvider?
    
    enum AuthProvider: String {
        case email
        case phone
        case apple
        case google
        case facebook
    }
}
