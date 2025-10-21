import SwiftUI

struct DateOfBirthStepView: View {
    @ObservedObject var viewModel: OnboardingViewModel
    
    var body: some View {
        VStack(spacing: 24) {
            Spacer()
            
            Image(systemName: "calendar")
                .font(.system(size: 60))
                .foregroundColor(.blue)
            
            Text("When's your birthday?")
                .font(.title.bold())
                .multilineTextAlignment(.center)
            
            DatePicker(
                "",
                selection: $viewModel.dateOfBirth,
                in: ...Date(),
                displayedComponents: .date
            )
            .datePickerStyle(.wheel)
            .labelsHidden()
            .padding(.horizontal, 40)
            
            Text("You must be 18+ to use Sway")
                .font(.caption)
                .foregroundColor(.secondary)
            
            Spacer()
        }
    }
}

struct GenderStepView: View {
    @ObservedObject var viewModel: OnboardingViewModel
    
    var body: some View {
        VStack(spacing: 24) {
            Spacer()
            
            Image(systemName: "person.2.fill")
                .font(.system(size: 60))
                .foregroundColor(.blue)
            
            Text("What's your gender?")
                .font(.title.bold())
                .multilineTextAlignment(.center)
            
            VStack(spacing: 12) {
                ForEach(User.Gender.allCases, id: \.self) { gender in
                    Button(action: {
                        viewModel.selectedGender = gender
                    }) {
                        HStack {
                            Text(gender.rawValue)
                                .font(.headline)
                                .foregroundColor(viewModel.selectedGender == gender ? .white : .primary)
                            Spacer()
                            if viewModel.selectedGender == gender {
                                Image(systemName: "checkmark.circle.fill")
                                    .foregroundColor(.white)
                            }
                        }
                        .padding()
                        .background(viewModel.selectedGender == gender ? Color.blue : Color(.systemGray6))
                        .cornerRadius(12)
                    }
                }
            }
            .padding(.horizontal, 40)
            
            Spacer()
        }
    }
}

struct LocationStepView: View {
    @ObservedObject var viewModel: OnboardingViewModel
    @StateObject private var locationService = LocationService.shared
    @State private var showPermissionAlert = false
    
    var body: some View {
        VStack(spacing: 24) {
            Spacer()
            
            Image(systemName: "location.circle.fill")
                .font(.system(size: 60))
                .foregroundColor(.blue)
            
            Text("Enable Location")
                .font(.title.bold())
                .multilineTextAlignment(.center)
            
            Text("We'll use your location to find matches nearby")
                .font(.body)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 40)
            
            if locationService.authorizationStatus == .authorizedWhenInUse ||
               locationService.authorizationStatus == .authorizedAlways {
                VStack(spacing: 8) {
                    Image(systemName: "checkmark.circle.fill")
                        .font(.system(size: 40))
                        .foregroundColor(.green)
                    Text("Location Enabled")
                        .font(.headline)
                        .foregroundColor(.green)
                }
                .padding()
            } else {
                Button(action: {
                    locationService.requestPermission()
                }) {
                    Text("Enable Location")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: 54)
                        .background(Color.blue)
                        .cornerRadius(27)
                }
                .padding(.horizontal, 40)
            }
            
            Spacer()
        }
    }
}
