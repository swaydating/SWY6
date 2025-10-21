import Foundation

extension String {
    var isValidEmail: Bool {
        ValidationHelper.isValidEmail(self)
    }
    
    var isValidPhoneNumber: Bool {
        ValidationHelper.isValidPhoneNumber(self)
    }
    
    func truncated(to length: Int, addEllipsis: Bool = true) -> String {
        if self.count <= length {
            return self
        }
        let truncated = String(self.prefix(length))
        return addEllipsis ? truncated + "..." : truncated
    }
}

extension Date {
    var age: Int {
        Calendar.current.dateComponents([.year], from: self, to: Date()).year ?? 0
    }
    
    var isOver18: Bool {
        age >= 18
    }
    
    func formatted(style: DateFormatter.Style = .medium) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = style
        formatter.timeStyle = .none
        return formatter.string(from: self)
    }
}

extension Array {
    func chunked(into size: Int) -> [[Element]] {
        stride(from: 0, to: count, by: size).map {
            Array(self[$0..<Swift.min($0 + size, count)])
        }
    }
}
