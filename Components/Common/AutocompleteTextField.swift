import SwiftUI
import Combine

struct AutocompleteTextField: View {
    let placeholder: String
    @Binding var text: String
    let suggestions: [String]
    @State private var showSuggestions = false
    let onSelect: (String) -> Void
    
    var filteredSuggestions: [String] {
        if text.isEmpty {
            return []
        }
        return suggestions.filter { $0.lowercased().contains(text.lowercased()) }
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            TextField(placeholder, text: $text)
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(12)
                .onChange(of: text) { _ in
                    showSuggestions = !text.isEmpty && !filteredSuggestions.isEmpty
                }
            
            if showSuggestions && !filteredSuggestions.isEmpty {
                VStack(alignment: .leading, spacing: 0) {
                    ForEach(filteredSuggestions.prefix(5), id: \.self) { suggestion in
                        Button(action: {
                            text = suggestion
                            onSelect(suggestion)
                            showSuggestions = false
                        }) {
                            HStack {
                                Image(systemName: "magnifyingglass")
                                    .foregroundColor(.secondary)
                                Text(suggestion)
                                    .foregroundColor(.primary)
                                Spacer()
                            }
                            .padding()
                        }
                        Divider()
                    }
                }
                .background(Color(.systemBackground))
                .cornerRadius(12)
                .shadow(radius: 4)
                .padding(.top, 4)
            }
        }
    }
}

class AutocompleteService: ObservableObject {
    static let shared = AutocompleteService()
    
    private init() {}
    
    // Location suggestions
    func getLocationSuggestions(_ query: String) -> [String] {
        let cities = [
            "New York, NY", "Los Angeles, CA", "Chicago, IL", "Houston, TX",
            "Phoenix, AZ", "Philadelphia, PA", "San Antonio, TX", "San Diego, CA",
            "Dallas, TX", "San Jose, CA", "Austin, TX", "Jacksonville, FL",
            "San Francisco, CA", "Seattle, WA", "Denver, CO", "Boston, MA",
            "Portland, OR", "Miami, FL", "Atlanta, GA", "Las Vegas, NV"
        ]
        return cities.filter { $0.lowercased().contains(query.lowercased()) }
    }
    
    // Occupation suggestions
    func getOccupationSuggestions(_ query: String) -> [String] {
        let occupations = [
            "Software Engineer", "Teacher", "Nurse", "Doctor", "Lawyer",
            "Accountant", "Designer", "Marketing Manager", "Sales Representative",
            "Consultant", "Engineer", "Entrepreneur", "Student", "Artist",
            "Writer", "Chef", "Real Estate Agent", "Financial Analyst"
        ]
        return occupations.filter { $0.lowercased().contains(query.lowercased()) }
    }
    
    // Education suggestions
    func getEducationSuggestions(_ query: String) -> [String] {
        let schools = [
            "Harvard University", "Stanford University", "MIT", "Yale University",
            "Princeton University", "Columbia University", "University of Chicago",
            "UC Berkeley", "UCLA", "University of Michigan", "NYU",
            "University of Texas", "University of Washington", "Boston University"
        ]
        return schools.filter { $0.lowercased().contains(query.lowercased()) }
    }
}
