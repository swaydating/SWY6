import SwiftUI

struct VerificationCodeStepView: View {
    @ObservedObject var viewModel: OnboardingViewModel
    @State private var code = ""
    @FocusState private var isCodeFocused: Bool
    
    var body: some View {
        VStack(spacing: 24) {
            Spacer()
            
            Image(systemName: "lock.shield.fill")
                .font(.system(size: 60))
                .foregroundColor(.green)
            
            Text("Enter Verification Code")
                .font(.title.bold())
            
            Text("We sent a code to your phone/email")
                .font(.body)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
            
            // Code Input Field
            HStack(spacing: 12) {
                ForEach(0..<6) { index in
                    CodeDigitView(
                        digit: code.count > index ? String(code[code.index(code.startIndex, offsetBy: index)]) : ""
                    )
                }
            }
            .padding(.horizontal, 20)
            
            TextField("", text: $code)
                .keyboardType(.numberPad)
                .focused($isCodeFocused)
                .opacity(0)
                .frame(height: 1)
                .onChange(of: code) { newValue in
                    if newValue.count > 6 {
                        code = String(newValue.prefix(6))
                    }
                }
            
            Button("Resend Code") {
                // Resend logic
            }
            .foregroundColor(.blue)
            .padding(.top, 8)
            
            Spacer()
        }
        .onAppear {
            isCodeFocused = true
        }
    }
}

struct CodeDigitView: View {
    let digit: String
    
    var body: some View {
        Text(digit)
            .font(.title.bold())
            .frame(width: 50, height: 60)
            .background(Color(.systemGray6))
            .cornerRadius(12)
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(digit.isEmpty ? Color.clear : Color.blue, lineWidth: 2)
            )
    }
}

struct CreatePasswordStepView: View {
    @ObservedObject var viewModel: OnboardingViewModel
    @State private var password = ""
    @State private var confirmPassword = ""
    @State private var showPassword = false
    
    var passwordStrength: String {
        if password.isEmpty { return "" }
        if password.count < 6 { return "Weak" }
        if password.count < 8 { return "Fair" }
        if ValidationHelper.isStrongPassword(password) { return "Strong" }
        return "Good"
    }
    
    var strengthColor: Color {
        switch passwordStrength {
        case "Weak": return .red
        case "Fair": return .orange
        case "Good": return .yellow
        case "Strong": return .green
        default: return .gray
        }
    }
    
    var body: some View {
        VStack(spacing: 24) {
            Spacer()
            
            Image(systemName: "key.fill")
                .font(.system(size: 60))
                .foregroundColor(.blue)
            
            Text("Create a Password")
                .font(.title.bold())
            
            Text("Must be at least 8 characters")
                .font(.subheadline)
                .foregroundColor(.secondary)
            
            VStack(spacing: 16) {
                HStack {
                    if showPassword {
                        TextField("Password", text: $password)
                    } else {
                        SecureField("Password", text: $password)
                    }
                    
                    Button(action: { showPassword.toggle() }) {
                        Image(systemName: showPassword ? "eye.slash.fill" : "eye.fill")
                            .foregroundColor(.secondary)
                    }
                }
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(12)
                
                if !password.isEmpty {
                    HStack {
                        Text("Password Strength: \(passwordStrength)")
                            .font(.caption)
                            .foregroundColor(strengthColor)
                        Spacer()
                    }
                }
                
                HStack {
                    if showPassword {
                        TextField("Confirm Password", text: $confirmPassword)
                    } else {
                        SecureField("Confirm Password", text: $confirmPassword)
                    }
                }
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(12)
                
                if !confirmPassword.isEmpty && password != confirmPassword {
                    HStack {
                        Text("Passwords don't match")
                            .font(.caption)
                            .foregroundColor(.red)
                        Spacer()
                    }
                }
            }
            .padding(.horizontal, 40)
            
            VStack(alignment: .leading, spacing: 8) {
                PasswordRequirement(text: "At least 8 characters", isMet: password.count >= 8)
                PasswordRequirement(text: "Contains uppercase letter", isMet: password.range(of: "[A-Z]", options: .regularExpression) != nil)
                PasswordRequirement(text: "Contains lowercase letter", isMet: password.range(of: "[a-z]", options: .regularExpression) != nil)
                PasswordRequirement(text: "Contains number", isMet: password.range(of: "[0-9]", options: .regularExpression) != nil)
            }
            .padding(.horizontal, 40)
            .font(.caption)
            
            Spacer()
        }
    }
}

struct PasswordRequirement: View {
    let text: String
    let isMet: Bool
    
    var body: some View {
        HStack(spacing: 8) {
            Image(systemName: isMet ? "checkmark.circle.fill" : "circle")
                .foregroundColor(isMet ? .green : .gray)
            Text(text)
                .foregroundColor(isMet ? .primary : .secondary)
        }
    }
}

struct PhotoVerificationStepView: View {
    @ObservedObject var viewModel: OnboardingViewModel
    @State private var showCamera = false
    @State private var capturedImage: UIImage?
    
    var body: some View {
        VStack(spacing: 24) {
            Spacer()
            
            Image(systemName: "camera.circle.fill")
                .font(.system(size: 80))
                .foregroundColor(.blue)
            
            Text("Photo Verification")
                .font(.title.bold())
            
            Text("Take a quick selfie to verify it's really you")
                .font(.body)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 40)
            
            if let image = capturedImage {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 200, height: 200)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.blue, lineWidth: 4))
            } else {
                Circle()
                    .stroke(style: StrokeStyle(lineWidth: 4, dash: [10]))
                    .foregroundColor(.gray)
                    .frame(width: 200, height: 200)
                    .overlay(
                        VStack {
                            Image(systemName: "person.fill")
                                .font(.system(size: 60))
                                .foregroundColor(.gray)
                            Text("Position your face here")
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }
                    )
            }
            
            Button(action: { showCamera = true }) {
                HStack {
                    Image(systemName: "camera.fill")
                    Text(capturedImage == nil ? "Take Photo" : "Retake Photo")
                }
                .font(.headline)
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .frame(height: 54)
                .background(Color.blue)
                .cornerRadius(27)
            }
            .padding(.horizontal, 40)
            
            VStack(alignment: .leading, spacing: 8) {
                VerificationTip(text: "Look directly at camera")
                VerificationTip(text: "Remove sunglasses and hats")
                VerificationTip(text: "Good lighting on your face")
            }
            .padding(.horizontal, 40)
            
            Spacer()
        }
    }
}

struct VerificationTip: View {
    let text: String
    
    var body: some View {
        HStack(spacing: 8) {
            Image(systemName: "checkmark.circle")
                .foregroundColor(.blue)
            Text(text)
                .font(.subheadline)
        }
    }
}

struct AdditionalPhotosStepView: View {
    @ObservedObject var viewModel: OnboardingViewModel
    @State private var showImagePicker = false
    
    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                Image(systemName: "photo.stack.fill")
                    .font(.system(size: 60))
                    .foregroundColor(.purple)
                    .padding(.top, 40)
                
                Text("Add More Photos")
                    .font(.title.bold())
                
                Text("You can add up to \(Constants.App.maximumPhotoCount) photos")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                
                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())], spacing: 12) {
                    ForEach(0..<6) { index in
                        if index < viewModel.photos.count {
                            ZStack(alignment: .topTrailing) {
                                Image(uiImage: viewModel.photos[index])
                                    .resizable()
                                    .scaledToFill()
                                    .frame(height: 120)
                                    .clipped()
                                    .cornerRadius(12)
                                
                                Button(action: {
                                    viewModel.photos.remove(at: index)
                                }) {
                                    Image(systemName: "xmark.circle.fill")
                                        .font(.title2)
                                        .foregroundColor(.white)
                                        .background(Circle().fill(Color.black.opacity(0.6)))
                                }
                                .padding(8)
                            }
                        } else {
                            Button(action: { showImagePicker = true }) {
                                VStack {
                                    Image(systemName: "plus")
                                        .font(.title)
                                        .foregroundColor(.gray)
                                }
                                .frame(height: 120)
                                .frame(maxWidth: .infinity)
                                .background(Color(.systemGray6))
                                .cornerRadius(12)
                            }
                        }
                    }
                }
                .padding(.horizontal, 20)
                
                Text("Tip: Add photos that show your personality and interests")
                    .font(.caption)
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 40)
            }
        }
    }
}

struct ProfileVideoStepView: View {
    @ObservedObject var viewModel: OnboardingViewModel
    @State private var hasVideo = false
    
    var body: some View {
        VStack(spacing: 24) {
            Spacer()
            
            Image(systemName: "video.circle.fill")
                .font(.system(size: 80))
                .foregroundColor(.red)
            
            Text("Add a Profile Video")
                .font(.title.bold())
            
            Text("Optional: Record a short video to introduce yourself")
                .font(.body)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 40)
            
            if hasVideo {
                Rectangle()
                    .fill(Color.black)
                    .frame(height: 300)
                    .cornerRadius(16)
                    .overlay(
                        VStack {
                            Image(systemName: "play.circle.fill")
                                .font(.system(size: 60))
                                .foregroundColor(.white)
                            Text("Preview")
                                .foregroundColor(.white)
                        }
                    )
                    .padding(.horizontal, 40)
            } else {
                Rectangle()
                    .fill(Color(.systemGray6))
                    .frame(height: 300)
                    .cornerRadius(16)
                    .overlay(
                        VStack(spacing: 16) {
                            Image(systemName: "video.fill")
                                .font(.system(size: 60))
                                .foregroundColor(.gray)
                            Text("No video yet")
                                .foregroundColor(.secondary)
                        }
                    )
                    .padding(.horizontal, 40)
            }
            
            Button(action: { hasVideo.toggle() }) {
                HStack {
                    Image(systemName: "video.fill")
                    Text(hasVideo ? "Record New Video" : "Record Video")
                }
                .font(.headline)
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .frame(height: 54)
                .background(Color.red)
                .cornerRadius(27)
            }
            .padding(.horizontal, 40)
            
            Button("Skip") {
                // Skip logic handled by parent
            }
            .foregroundColor(.blue)
            
            Spacer()
        }
    }
}
