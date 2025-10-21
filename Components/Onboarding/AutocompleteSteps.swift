import SwiftUI

struct OccupationStepView: View {
    @ObservedObject var viewModel: OnboardingViewModel
    @State private var occupation = ""
    @StateObject private var autocomplete = AutocompleteService.shared
    
    var body: some View {
        VStack(spacing: 24) {
            Spacer()
            
            Image(systemName: "briefcase.fill")
                .font(.system(size: 60))
                .foregroundColor(.blue)
            
            Text("What do you do?")
                .font(.title.bold())
                .multilineTextAlignment(.center)
            
            AutocompleteTextField(
                placeholder: "Your Occupation",
                text: $occupation,
                suggestions: autocomplete.getOccupationSuggestions(occupation)
            ) { selected in
                occupation = selected
            }
            .padding(.horizontal, 40)
            
            Text("This will be visible on your profile")
                .font(.caption)
                .foregroundColor(.secondary)
            
            Spacer()
        }
    }
}

struct EducationStepView: View {
    @ObservedObject var viewModel: OnboardingViewModel
    @State private var education = ""
    @StateObject private var autocomplete = AutocompleteService.shared
    
    var body: some View {
        VStack(spacing: 24) {
            Spacer()
            
            Image(systemName: "graduationcap.fill")
                .font(.system(size: 60))
                .foregroundColor(.blue)
            
            Text("Where did you study?")
                .font(.title.bold())
                .multilineTextAlignment(.center)
            
            AutocompleteTextField(
                placeholder: "Your School/University",
                text: $education,
                suggestions: autocomplete.getEducationSuggestions(education)
            ) { selected in
                education = selected
            }
            .padding(.horizontal, 40)
            
            Text("Optional, but helps with matching")
                .font(.caption)
                .foregroundColor(.secondary)
            
            Spacer()
        }
    }
}

struct CityStepView: View {
    @ObservedObject var viewModel: OnboardingViewModel
    @State private var city = ""
    @StateObject private var autocomplete = AutocompleteService.shared
    
    var body: some View {
        VStack(spacing: 24) {
            Spacer()
            
            Image(systemName: "building.2.fill")
                .font(.system(size: 60))
                .foregroundColor(.blue)
            
            Text("Where do you live?")
                .font(.title.bold())
                .multilineTextAlignment(.center)
            
            AutocompleteTextField(
                placeholder: "City, State",
                text: $city,
                suggestions: autocomplete.getLocationSuggestions(city)
            ) { selected in
                city = selected
            }
            .padding(.horizontal, 40)
            
            Text("We'll show you matches nearby")
                .font(.caption)
                .foregroundColor(.secondary)
            
            Spacer()
        }
    }
}
