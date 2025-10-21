import SwiftUI

struct ProfileView: View {
    @ObservedObject private var authService = AuthService.shared
    @State private var showEditProfile = false
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 24) {
                    if let user = authService.currentUser {
                        // Profile Header
                        VStack(spacing: 12) {
                            Circle()
                                .fill(LinearGradient(
                                    colors: [.blue, .purple],
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                ))
                                .frame(width: 120, height: 120)
                                .overlay(
                                    Text(user.firstName.prefix(1))
                                        .font(.system(size: 48, weight: .bold))
                                        .foregroundColor(.white)
                                )
                            
                            HStack {
                                Text("\(user.firstName) \(user.lastName)")
                                    .font(.title.bold())
                                
                                if user.isVerified {
                                    Image(systemName: "checkmark.seal.fill")
                                        .foregroundColor(.blue)
                                }
                            }
                            
                            if let age = user.dateOfBirth?.age {
                                Text("\(age) years old")
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                            }
                            
                            Button(action: { showEditProfile = true }) {
                                Text("Edit Profile")
                                    .font(.headline)
                                    .foregroundColor(.white)
                                    .frame(maxWidth: .infinity)
                                    .frame(height: 44)
                                    .background(Color.blue)
                                    .cornerRadius(22)
                            }
                            .padding(.horizontal, 40)
                        }
                        .padding(.top, 20)
                        
                        // Bio
                        if let bio = user.bio {
                            VStack(alignment: .leading, spacing: 8) {
                                Text("About")
                                    .font(.headline)
                                Text(bio)
                                    .font(.body)
                                    .foregroundColor(.secondary)
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding()
                            .background(Color(.systemGray6))
                            .cornerRadius(12)
                            .padding(.horizontal)
                        }
                        
                        // Interests
                        if !user.interests.isEmpty {
                            VStack(alignment: .leading, spacing: 12) {
                                Text("Interests")
                                    .font(.headline)
                                    .padding(.horizontal)
                                
                                ScrollView(.horizontal, showsIndicators: false) {
                                    HStack(spacing: 8) {
                                        ForEach(user.interests, id: \.self) { interest in
                                            Text(interest)
                                                .font(.subheadline)
                                                .padding(.horizontal, 16)
                                                .padding(.vertical, 8)
                                                .background(Color.blue.opacity(0.1))
                                                .foregroundColor(.blue)
                                                .cornerRadius(16)
                                        }
                                    }
                                    .padding(.horizontal)
                                }
                            }
                        }
                        
                        // Photos
                        VStack(alignment: .leading, spacing: 12) {
                            Text("Photos")
                                .font(.headline)
                                .padding(.horizontal)
                            
                            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 12) {
                                ForEach(0..<4) { _ in
                                    Rectangle()
                                        .fill(LinearGradient(
                                            colors: [.blue.opacity(0.3), .purple.opacity(0.3)],
                                            startPoint: .topLeading,
                                            endPoint: .bottomTrailing
                                        ))
                                        .frame(height: 200)
                                        .cornerRadius(12)
                                }
                            }
                            .padding(.horizontal)
                        }
                        
                        // Settings
                        VStack(spacing: 0) {
                            NavigationLink(destination: SettingsView()) {
                                SettingsRow(icon: "gearshape.fill", title: "Settings", color: .gray)
                            }
                            
                            Button(action: {
                                authService.signOut()
                            }) {
                                SettingsRow(icon: "arrow.right.square.fill", title: "Sign Out", color: .red)
                            }
                        }
                        .background(Color(.systemGray6))
                        .cornerRadius(12)
                        .padding()
                    }
                }
            }
            .navigationTitle("Profile")
            .sheet(isPresented: $showEditProfile) {
                EditProfileView()
            }
        }
    }
}

struct SettingsRow: View {
    let icon: String
    let title: String
    let color: Color
    
    var body: some View {
        HStack {
            Image(systemName: icon)
                .foregroundColor(color)
                .frame(width: 30)
            Text(title)
                .foregroundColor(.primary)
            Spacer()
            Image(systemName: "chevron.right")
                .foregroundColor(.secondary)
                .font(.caption)
        }
        .padding()
    }
}

struct EditProfileView: View {
    @Environment(\.dismiss) private var dismiss
    @StateObject private var viewModel = OnboardingViewModel()
    
    var body: some View {
        NavigationView {
            Form {
                Section("Basic Info") {
                    TextField("First Name", text: $viewModel.firstName)
                    TextField("Last Name", text: $viewModel.lastName)
                }
                
                Section("About") {
                    TextEditor(text: $viewModel.bio)
                        .frame(height: 100)
                }
                
                Section("Interests") {
                    Text("Tap to edit interests")
                        .foregroundColor(.blue)
                }
            }
            .navigationTitle("Edit Profile")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        dismiss()
                    }
                }
            }
        }
    }
}
