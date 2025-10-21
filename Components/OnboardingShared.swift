import SwiftUI

// Step Header Component
struct StepHeader: View {
    var title: String
    var body: some View {
        Text(title)
            .font(.largeTitle)
            .padding()
    }
}

// Primary Button Function
func primaryButton(title: String, action: @escaping () -> Void) -> some View {
    Button(action: action) {
        Text(title)
            .fontWeight(.bold)
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(8)
    }
}

// Red Outline Skip Button
struct RedOutlineSkipButton: View {
    var body: some View {
        Button("Skip") {
            // Action here
        }
        .padding()
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(Color.red, lineWidth: 2)
        )
    }
}

// Hollow Red Skip Button
struct HollowRedSkipButton: View {
    var body: some View {
        Button("Skip") {
            // Action here
        }
        .padding()
        .border(Color.red, width: 2)
    }
}

// Mono Search Bar
struct MonoSearchBar: View {
    @Binding var searchText: String

    var body: some View {
        TextField("Search...", text: $searchText)
            .padding()
            .background(Color.gray.opacity(0.2))
            .cornerRadius(8)
    }
}

// Autocomplete Text Field
struct AutocompleteTextField: View {
    @Binding var text: String
    var suggestions: [String]

    var body: some View {
        VStack {
            TextField("Type here...", text: $text)
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(8)
            List(suggestions, id: \(\.self)) { suggestion in
                Text(suggestion)
            }
        }
    }
}

// Level Chips
struct LevelChips: View {
    var levels: [String]

    var body: some View {
        HStack {
            ForEach(levels, id: \(\.self)) { level in
                Text(level)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(8)
            }
        }
    }
}

// Chip Styles
struct RedSelectableChipStyle: View {
    var body: some View {
        Text("Red Selectable Chip")
            .padding()
            .background(Color.red)
            .cornerRadius(8)
    }
}

struct DateNightChipStyle: View {
    var body: some View {
        Text("Date Night Chip")
            .padding()
            .background(Color.pink)
            .cornerRadius(8)
    }
}

struct GamingChipStyle: View {
    var body: some View {
        Text("Gaming Chip")
            .padding()
            .background(Color.green)
            .cornerRadius(8)
    }
}

// Default Language and Culture Suggestion Arrays
let defaultLanguages = ["English", "Spanish", "French"]
let defaultCultures = ["American", "Mexican", "French"]

// Chip Column Layout Definitions
struct ChipColumnLayout: View {
    var chips: [String]

    var body: some View {
        VStack {
            ForEach(chips, id: \(\.self)) { chip in
                Text(chip)
                    .padding()
                    .background(Color.gray)
                    .cornerRadius(8)
            }
        }
    }
}