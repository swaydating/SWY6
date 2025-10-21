import SwiftUI

struct LookingForStepView: View {
    @ObservedObject var viewModel: OnboardingViewModel
    @State private var selectedOptions: Set<String> = []
    
    let options = ["Friends", "Dating", "Relationship", "Something Casual", "Not Sure Yet"]
    
    var body: some View {
        VStack(spacing: 24) {
            Spacer()
            
            Image(systemName: "heart.text.square.fill")
                .font(.system(size: 60))
                .foregroundColor(.pink)
            
            Text("What are you looking for?")
                .font(.title.bold())
                .multilineTextAlignment(.center)
            
            Text("Select all that apply")
                .font(.subheadline)
                .foregroundColor(.secondary)
            
            VStack(spacing: 12) {
                ForEach(options, id: \.self) { option in
                    SelectableOptionButton(
                        title: option,
                        isSelected: selectedOptions.contains(option)
                    ) {
                        if selectedOptions.contains(option) {
                            selectedOptions.remove(option)
                        } else {
                            selectedOptions.insert(option)
                        }
                    }
                }
            }
            .padding(.horizontal, 40)
            
            Spacer()
        }
    }
}

struct RelationshipGoalsStepView: View {
    @ObservedObject var viewModel: OnboardingViewModel
    @State private var selectedGoal: String?
    
    let goals = [
        "Long-term relationship",
        "Long-term, open to short",
        "Short-term, open to long",
        "Short-term fun",
        "New friends",
        "Still figuring it out"
    ]
    
    var body: some View {
        VStack(spacing: 24) {
            Spacer()
            
            Image(systemName: "target")
                .font(.system(size: 60))
                .foregroundColor(.blue)
            
            Text("Relationship Goals")
                .font(.title.bold())
                .multilineTextAlignment(.center)
            
            VStack(spacing: 12) {
                ForEach(goals, id: \.self) { goal in
                    SelectableOptionButton(
                        title: goal,
                        isSelected: selectedGoal == goal
                    ) {
                        selectedGoal = goal
                    }
                }
            }
            .padding(.horizontal, 40)
            
            Spacer()
        }
    }
}

struct AgePreferenceStepView: View {
    @ObservedObject var viewModel: OnboardingViewModel
    @State private var minAge: Double = 18
    @State private var maxAge: Double = 99
    
    var body: some View {
        VStack(spacing: 24) {
            Spacer()
            
            Image(systemName: "person.2.fill")
                .font(.system(size: 60))
                .foregroundColor(.blue)
            
            Text("Age Range")
                .font(.title.bold())
            
            Text("Show me people between")
                .font(.body)
                .foregroundColor(.secondary)
            
            VStack(spacing: 30) {
                VStack(spacing: 8) {
                    Text("Min Age: \(Int(minAge))")
                        .font(.headline)
                    Slider(value: $minAge, in: 18...99, step: 1)
                        .accentColor(.blue)
                }
                
                VStack(spacing: 8) {
                    Text("Max Age: \(Int(maxAge))")
                        .font(.headline)
                    Slider(value: $maxAge, in: 18...99, step: 1)
                        .accentColor(.blue)
                }
            }
            .padding(.horizontal, 40)
            
            Spacer()
        }
    }
}

struct DistancePreferenceStepView: View {
    @ObservedObject var viewModel: OnboardingViewModel
    @State private var distance: Double = 25
    
    var body: some View {
        VStack(spacing: 24) {
            Spacer()
            
            Image(systemName: "location.circle.fill")
                .font(.system(size: 60))
                .foregroundColor(.blue)
            
            Text("Distance")
                .font(.title.bold())
            
            Text("Maximum distance: \(Int(distance)) miles")
                .font(.headline)
                .foregroundColor(.blue)
            
            Slider(value: $distance, in: 1...100, step: 1)
                .accentColor(.blue)
                .padding(.horizontal, 40)
            
            Text("Show me people within this distance")
                .font(.body)
                .foregroundColor(.secondary)
            
            Spacer()
        }
    }
}

struct GenderPreferenceStepView: View {
    @ObservedObject var viewModel: OnboardingViewModel
    @State private var selectedGenders: Set<User.Gender> = []
    
    var body: some View {
        VStack(spacing: 24) {
            Spacer()
            
            Image(systemName: "person.2.crop.square.stack.fill")
                .font(.system(size: 60))
                .foregroundColor(.purple)
            
            Text("Show Me")
                .font(.title.bold())
            
            Text("Select all that apply")
                .font(.subheadline)
                .foregroundColor(.secondary)
            
            VStack(spacing: 12) {
                ForEach(User.Gender.allCases, id: \.self) { gender in
                    SelectableOptionButton(
                        title: gender.rawValue,
                        isSelected: selectedGenders.contains(gender)
                    ) {
                        if selectedGenders.contains(gender) {
                            selectedGenders.remove(gender)
                        } else {
                            selectedGenders.insert(gender)
                        }
                    }
                }
            }
            .padding(.horizontal, 40)
            
            Spacer()
        }
    }
}

struct SelectableOptionButton: View {
    let title: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack {
                Text(title)
                    .font(.headline)
                Spacer()
                if isSelected {
                    Image(systemName: "checkmark.circle.fill")
                        .foregroundColor(.white)
                }
            }
            .padding()
            .foregroundColor(isSelected ? .white : .primary)
            .background(isSelected ? Color.blue : Color(.systemGray6))
            .cornerRadius(12)
        }
    }
}
