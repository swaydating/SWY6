import SwiftUI

struct FirstNameStepView: View {
    @ObservedObject var viewModel: OnboardingViewModel
    
    var body: some View {
        VStack(spacing: 24) {
            Spacer()
            
            Image(systemName: "person.fill")
                .font(.system(size: 60))
                .foregroundColor(.blue)
            
            Text("What's your first name?")
                .font(.title.bold())
                .multilineTextAlignment(.center)
            
            TextField("First Name", text: $viewModel.firstName)
                .font(.title2)
                .multilineTextAlignment(.center)
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(12)
                .padding(.horizontal, 40)
            
            Text("This will be visible on your profile")
                .font(.caption)
                .foregroundColor(.secondary)
            
            Spacer()
        }
    }
}

struct LastNameStepView: View {
    @ObservedObject var viewModel: OnboardingViewModel
    
    var body: some View {
        VStack(spacing: 24) {
            Spacer()
            
            Image(systemName: "person.fill")
                .font(.system(size: 60))
                .foregroundColor(.blue)
            
            Text("What's your last name?")
                .font(.title.bold())
                .multilineTextAlignment(.center)
            
            TextField("Last Name", text: $viewModel.lastName)
                .font(.title2)
                .multilineTextAlignment(.center)
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(12)
                .padding(.horizontal, 40)
            
            Text("Only first initial will be shown")
                .font(.caption)
                .foregroundColor(.secondary)
            
            Spacer()
        }
    }
}

struct EmailStepView: View {
    @ObservedObject var viewModel: OnboardingViewModel
    @State private var email = ""
    
    var body: some View {
        VStack(spacing: 24) {
            Spacer()
            
            Image(systemName: "envelope.fill")
                .font(.system(size: 60))
                .foregroundColor(.blue)
            
            Text("What's your email?")
                .font(.title.bold())
                .multilineTextAlignment(.center)
            
            TextField("Email", text: $email)
                .keyboardType(.emailAddress)
                .textInputAutocapitalization(.never)
                .font(.title3)
                .multilineTextAlignment(.center)
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(12)
                .padding(.horizontal, 40)
            
            Text("We'll never share your email")
                .font(.caption)
                .foregroundColor(.secondary)
            
            Spacer()
        }
    }
}

struct PhoneNumberStepView: View {
    @ObservedObject var viewModel: OnboardingViewModel
    @State private var phoneNumber = ""
    
    var body: some View {
        VStack(spacing: 24) {
            Spacer()
            
            Image(systemName: "phone.fill")
                .font(.system(size: 60))
                .foregroundColor(.blue)
            
            Text("What's your phone number?")
                .font(.title.bold())
                .multilineTextAlignment(.center)
            
            TextField("Phone Number", text: $phoneNumber)
                .keyboardType(.phonePad)
                .font(.title3)
                .multilineTextAlignment(.center)
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(12)
                .padding(.horizontal, 40)
            
            Text("For account security")
                .font(.caption)
                .foregroundColor(.secondary)
            
            Spacer()
        }
    }
}
