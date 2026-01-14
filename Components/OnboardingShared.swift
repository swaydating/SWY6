import SwiftUI

// Step Header Component
struct StepHeader: View {
    @Binding var step: OnboardingStep
    var showBack: Bool = true
    var showHelp: Bool = false
    
    var body: some View {
        HStack {
            if showBack, let previousStep = step.previous() {
                Button {
                    step = previousStep
                } label: {
                    Image(systemName: "chevron.left")
                        .foregroundColor(.white)
                }
            }
            Spacer()
            if showHelp {
                Button {
                    // Help action
                } label: {
                    Image(systemName: "questionmark.circle")
                        .foregroundColor(.white)
                }
            }
        }
        .padding()
    }
}

// Primary Button Function
func primaryButton(_ title: String, enabled: Bool = true, action: @escaping () -> Void) -> some View {
    Button(action: action) {
        Text(title)
            .fontWeight(.bold)
            .frame(maxWidth: .infinity)
            .padding()
            .background(enabled ? Color.red : Color.gray)
            .foregroundColor(.white)
            .cornerRadius(12)
    }
    .disabled(!enabled)
}

// Red Outline Skip Button
struct RedOutlineSkipButton: View {
    var action: () -> Void
    
    init(action: @escaping () -> Void) {
        self.action = action
    }
    
    var body: some View {
        Button("Skip", action: action)
            .foregroundColor(.red)
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
struct RedSelectableChipStyle: ButtonStyle {
    var selected: Bool
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .background(selected ? Color.red : Color.white.opacity(0.1))
            .cornerRadius(16)
            .overlay(
                RoundedRectangle(cornerRadius: 16)
                    .stroke(Color.red, lineWidth: selected ? 0 : 1)
            )
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
let defaultLanguageSuggestions = ["English", "Spanish", "French", "Mandarin", "Hindi", "Arabic", "Portuguese", "German", "Japanese", "Korean"]
let defaultCultureSuggestions = ["British", "Indian", "Nigerian", "American", "Chinese", "Brazilian", "Mexican", "Japanese", "Italian", "French"]

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