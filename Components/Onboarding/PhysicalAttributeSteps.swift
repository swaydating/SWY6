import SwiftUI

struct HeightStepView: View {
    @ObservedObject var viewModel: OnboardingViewModel
    @State private var heightFeet: Double = 5
    @State private var heightInches: Double = 8
    
    var body: some View {
        VStack(spacing: 24) {
            Spacer()
            
            Image(systemName: "ruler")
                .font(.system(size: 60))
                .foregroundColor(.blue)
            
            Text("What's your height?")
                .font(.title.bold())
            
            HStack(spacing: 30) {
                VStack {
                    Text("\(Int(heightFeet)) ft")
                        .font(.title2.bold())
                    Picker("Feet", selection: $heightFeet) {
                        ForEach(4...7, id: \.self) { feet in
                            Text("\(feet)").tag(Double(feet))
                        }
                    }
                    .pickerStyle(.wheel)
                    .frame(width: 100)
                }
                
                VStack {
                    Text("\(Int(heightInches)) in")
                        .font(.title2.bold())
                    Picker("Inches", selection: $heightInches) {
                        ForEach(0...11, id: \.self) { inches in
                            Text("\(inches)").tag(Double(inches))
                        }
                    }
                    .pickerStyle(.wheel)
                    .frame(width: 100)
                }
            }
            
            Text("Total: \(Int(heightFeet))'\(Int(heightInches))\" (\(Int(heightFeet * 30.48 + heightInches * 2.54)) cm)")
                .font(.subheadline)
                .foregroundColor(.secondary)
            
            Spacer()
        }
    }
}

struct EthnicityStepView: View {
    @ObservedObject var viewModel: OnboardingViewModel
    @State private var selectedEthnicities: Set<String> = []
    
    let ethnicities = [
        "Asian",
        "Black / African Descent",
        "Hispanic / Latino",
        "Middle Eastern",
        "Native American",
        "Pacific Islander",
        "White / Caucasian",
        "Mixed",
        "Other",
        "Prefer not to say"
    ]
    
    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                Image(systemName: "globe")
                    .font(.system(size: 60))
                    .foregroundColor(.blue)
                    .padding(.top, 40)
                
                Text("What's your ethnicity?")
                    .font(.title.bold())
                
                Text("Select all that apply")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                
                VStack(spacing: 12) {
                    ForEach(ethnicities, id: \.self) { ethnicity in
                        SelectableOptionButton(
                            title: ethnicity,
                            isSelected: selectedEthnicities.contains(ethnicity)
                        ) {
                            if selectedEthnicities.contains(ethnicity) {
                                selectedEthnicities.remove(ethnicity)
                            } else {
                                selectedEthnicities.insert(ethnicity)
                            }
                        }
                    }
                }
                .padding(.horizontal, 40)
            }
        }
    }
}

struct BodyTypeStepView: View {
    @ObservedObject var viewModel: OnboardingViewModel
    @State private var selectedBodyType: String?
    
    let bodyTypes = [
        "Slim",
        "Athletic",
        "Average",
        "Muscular",
        "Curvy",
        "A few extra pounds",
        "Plus size",
        "Prefer not to say"
    ]
    
    var body: some View {
        VStack(spacing: 24) {
            Spacer()
            
            Image(systemName: "figure.walk")
                .font(.system(size: 60))
                .foregroundColor(.blue)
            
            Text("What's your body type?")
                .font(.title.bold())
            
            VStack(spacing: 12) {
                ForEach(bodyTypes, id: \.self) { bodyType in
                    SelectableOptionButton(
                        title: bodyType,
                        isSelected: selectedBodyType == bodyType
                    ) {
                        selectedBodyType = bodyType
                    }
                }
            }
            .padding(.horizontal, 40)
            
            Spacer()
        }
    }
}

struct HairColorStepView: View {
    @ObservedObject var viewModel: OnboardingViewModel
    @State private var selectedColor: String?
    
    let colors = [
        "Black",
        "Brown",
        "Blonde",
        "Red",
        "Gray / White",
        "Bald",
        "Other",
        "Prefer not to say"
    ]
    
    var body: some View {
        VStack(spacing: 24) {
            Spacer()
            
            Image(systemName: "paintbrush.fill")
                .font(.system(size: 60))
                .foregroundColor(.brown)
            
            Text("What's your hair color?")
                .font(.title.bold())
            
            VStack(spacing: 12) {
                ForEach(colors, id: \.self) { color in
                    SelectableOptionButton(
                        title: color,
                        isSelected: selectedColor == color
                    ) {
                        selectedColor = color
                    }
                }
            }
            .padding(.horizontal, 40)
            
            Spacer()
        }
    }
}

struct EyeColorStepView: View {
    @ObservedObject var viewModel: OnboardingViewModel
    @State private var selectedColor: String?
    
    let colors = [
        "Brown",
        "Blue",
        "Green",
        "Hazel",
        "Gray",
        "Amber",
        "Other"
    ]
    
    var body: some View {
        VStack(spacing: 24) {
            Spacer()
            
            Image(systemName: "eye.fill")
                .font(.system(size: 60))
                .foregroundColor(.blue)
            
            Text("What's your eye color?")
                .font(.title.bold())
            
            VStack(spacing: 12) {
                ForEach(colors, id: \.self) { color in
                    SelectableOptionButton(
                        title: color,
                        isSelected: selectedColor == color
                    ) {
                        selectedColor = color
                    }
                }
            }
            .padding(.horizontal, 40)
            
            Spacer()
        }
    }
}

struct IncomeStepView: View {
    @ObservedObject var viewModel: OnboardingViewModel
    @State private var selectedIncome: String?
    
    let incomeRanges = [
        "Under $25,000",
        "$25,000 - $50,000",
        "$50,000 - $75,000",
        "$75,000 - $100,000",
        "$100,000 - $150,000",
        "$150,000 - $200,000",
        "Over $200,000",
        "Prefer not to say"
    ]
    
    var body: some View {
        VStack(spacing: 24) {
            Spacer()
            
            Image(systemName: "dollarsign.circle.fill")
                .font(.system(size: 60))
                .foregroundColor(.green)
            
            Text("Annual Income")
                .font(.title.bold())
            
            Text("Optional - this won't be shown publicly")
                .font(.subheadline)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
            
            ScrollView {
                VStack(spacing: 12) {
                    ForEach(incomeRanges, id: \.self) { range in
                        SelectableOptionButton(
                            title: range,
                            isSelected: selectedIncome == range
                        ) {
                            selectedIncome = range
                        }
                    }
                }
            }
            .padding(.horizontal, 40)
            
            Spacer()
        }
    }
}

struct DrugsStepView: View {
    @ObservedObject var viewModel: OnboardingViewModel
    @State private var selectedOption: String?
    
    let options = [
        "Never",
        "Sometimes",
        "Regularly",
        "Prefer not to say"
    ]
    
    var body: some View {
        VStack(spacing: 24) {
            Spacer()
            
            Image(systemName: "leaf.fill")
                .font(.system(size: 60))
                .foregroundColor(.green)
            
            Text("Do you use recreational drugs?")
                .font(.title.bold())
                .multilineTextAlignment(.center)
            
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
