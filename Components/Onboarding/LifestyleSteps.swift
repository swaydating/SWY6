import SwiftUI

struct LifestyleStepView: View {
    let category: String
    let icon: String
    let options: [String]
    @Binding var selectedOption: String?
    
    var body: some View {
        VStack(spacing: 24) {
            Spacer()
            
            Image(systemName: icon)
                .font(.system(size: 60))
                .foregroundColor(.blue)
            
            Text(category)
                .font(.title.bold())
            
            VStack(spacing: 12) {
                ForEach(options, id: \.self) { option in
                    SelectableOptionButton(
                        title: option,
                        isSelected: selectedOption == option
                    ) {
                        selectedOption = option
                    }
                }
            }
            .padding(.horizontal, 40)
            
            Spacer()
        }
    }
}

struct SmokingStepView: View {
    @ObservedObject var viewModel: OnboardingViewModel
    @State private var smoking: String?
    
    let options = ["Never", "Sometimes", "Regularly", "Prefer not to say"]
    
    var body: some View {
        LifestyleStepView(
            category: "Do you smoke?",
            icon: "smoke.fill",
            options: options,
            selectedOption: $smoking
        )
    }
}

struct DrinkingStepView: View {
    @ObservedObject var viewModel: OnboardingViewModel
    @State private var drinking: String?
    
    let options = ["Never", "Socially", "Regularly", "Prefer not to say"]
    
    var body: some View {
        LifestyleStepView(
            category: "Do you drink?",
            icon: "wineglass.fill",
            options: options,
            selectedOption: $drinking
        )
    }
}

struct ExerciseStepView: View {
    @ObservedObject var viewModel: OnboardingViewModel
    @State private var exercise: String?
    
    let options = ["Every day", "Often", "Sometimes", "Never"]
    
    var body: some View {
        LifestyleStepView(
            category: "How often do you exercise?",
            icon: "figure.run",
            options: options,
            selectedOption: $exercise
        )
    }
}

struct DietStepView: View {
    @ObservedObject var viewModel: OnboardingViewModel
    @State private var diet: String?
    
    let options = ["Vegan", "Vegetarian", "Pescatarian", "Omnivore", "Carnivore", "Other"]
    
    var body: some View {
        LifestyleStepView(
            category: "What's your diet?",
            icon: "fork.knife",
            options: options,
            selectedOption: $diet
        )
    }
}

struct PetsStepView: View {
    @ObservedObject var viewModel: OnboardingViewModel
    @State private var pets: String?
    
    let options = ["Dog(s)", "Cat(s)", "Both", "Other pets", "No pets", "Want pets"]
    
    var body: some View {
        LifestyleStepView(
            category: "Do you have pets?",
            icon: "pawprint.fill",
            options: options,
            selectedOption: $pets
        )
    }
}

struct ChildrenStepView: View {
    @ObservedObject var viewModel: OnboardingViewModel
    @State private var children: String?
    
    let options = ["Have children", "Don't have children", "Prefer not to say"]
    
    var body: some View {
        LifestyleStepView(
            category: "Do you have children?",
            icon: "figure.and.child.holdinghands",
            options: options,
            selectedOption: $children
        )
    }
}

struct WantChildrenStepView: View {
    @ObservedObject var viewModel: OnboardingViewModel
    @State private var wantChildren: String?
    
    let options = ["Want children", "Don't want children", "Open to children", "Not sure yet"]
    
    var body: some View {
        LifestyleStepView(
            category: "Do you want children?",
            icon: "heart.circle.fill",
            options: options,
            selectedOption: $wantChildren
        )
    }
}

struct ReligionStepView: View {
    @ObservedObject var viewModel: OnboardingViewModel
    @State private var religion: String?
    
    let options = [
        "Christian", "Catholic", "Muslim", "Jewish", "Hindu",
        "Buddhist", "Spiritual", "Agnostic", "Atheist", "Other", "Prefer not to say"
    ]
    
    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                Image(systemName: "book.closed.fill")
                    .font(.system(size: 60))
                    .foregroundColor(.blue)
                    .padding(.top, 40)
                
                Text("What's your religion?")
                    .font(.title.bold())
                
                VStack(spacing: 12) {
                    ForEach(options, id: \.self) { option in
                        SelectableOptionButton(
                            title: option,
                            isSelected: religion == option
                        ) {
                            religion = option
                        }
                    }
                }
                .padding(.horizontal, 40)
            }
        }
    }
}

struct PoliticsStepView: View {
    @ObservedObject var viewModel: OnboardingViewModel
    @State private var politics: String?
    
    let options = [
        "Liberal", "Moderate", "Conservative", "Not political", "Other", "Prefer not to say"
    ]
    
    var body: some View {
        LifestyleStepView(
            category: "Political views?",
            icon: "building.columns.fill",
            options: options,
            selectedOption: $politics
        )
    }
}
