import SwiftUI

struct BioStepView: View {
    @ObservedObject var viewModel: OnboardingViewModel
    
    var body: some View {
        VStack(spacing: 24) {
            Spacer()
            
            Image(systemName: "text.bubble.fill")
                .font(.system(size: 60))
                .foregroundColor(.blue)
            
            Text("Tell us about yourself")
                .font(.title.bold())
                .multilineTextAlignment(.center)
            
            TextEditor(text: $viewModel.bio)
                .frame(height: 150)
                .padding(8)
                .background(Color(.systemGray6))
                .cornerRadius(12)
                .overlay(
                    Text(viewModel.bio.isEmpty ? "Write something interesting about yourself..." : "")
                        .foregroundColor(.gray)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 16)
                        .allowsHitTesting(false)
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                )
                .padding(.horizontal, 40)
            
            Text("\(viewModel.bio.count) / 500 characters (min. 20)")
                .font(.caption)
                .foregroundColor(viewModel.bio.count >= 20 ? .green : .secondary)
            
            Spacer()
        }
    }
}

struct InterestsStepView: View {
    @ObservedObject var viewModel: OnboardingViewModel
    
    let interests = [
        "Travel", "Music", "Movies", "Food", "Sports", "Fitness",
        "Reading", "Gaming", "Art", "Photography", "Cooking", "Dancing",
        "Hiking", "Yoga", "Fashion", "Technology", "Nature", "Pets",
        "Wine", "Coffee", "Theater", "Concerts", "Beach", "Mountains"
    ]
    
    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                Image(systemName: "star.fill")
                    .font(.system(size: 60))
                    .foregroundColor(.blue)
                    .padding(.top, 40)
                
                Text("What are your interests?")
                    .font(.title.bold())
                    .multilineTextAlignment(.center)
                
                Text("Select at least 3")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 100))], spacing: 12) {
                    ForEach(interests, id: \.self) { interest in
                        InterestTag(
                            title: interest,
                            isSelected: viewModel.selectedInterests.contains(interest)
                        ) {
                            if viewModel.selectedInterests.contains(interest) {
                                viewModel.selectedInterests.removeAll { $0 == interest }
                            } else {
                                viewModel.selectedInterests.append(interest)
                            }
                        }
                    }
                }
                .padding(.horizontal, 20)
                
                Spacer()
            }
        }
    }
}

struct InterestTag: View {
    let title: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.subheadline)
                .padding(.horizontal, 16)
                .padding(.vertical, 10)
                .background(isSelected ? Color.blue : Color(.systemGray6))
                .foregroundColor(isSelected ? .white : .primary)
                .cornerRadius(20)
        }
    }
}

struct PhotosStepView: View {
    @ObservedObject var viewModel: OnboardingViewModel
    @State private var showImagePicker = false
    
    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                Image(systemName: "photo.on.rectangle.angled")
                    .font(.system(size: 60))
                    .foregroundColor(.blue)
                    .padding(.top, 40)
                
                Text("Add your photos")
                    .font(.title.bold())
                    .multilineTextAlignment(.center)
                
                Text("Add at least 2 photos")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                
                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
                    ForEach(0..<6) { index in
                        if index < viewModel.photos.count {
                            Image(uiImage: viewModel.photos[index])
                                .resizable()
                                .scaledToFill()
                                .frame(height: 180)
                                .clipped()
                                .cornerRadius(12)
                        } else {
                            Button(action: { showImagePicker = true }) {
                                VStack {
                                    Image(systemName: "plus.circle.fill")
                                        .font(.system(size: 40))
                                        .foregroundColor(.blue)
                                    Text("Add Photo")
                                        .font(.caption)
                                }
                                .frame(height: 180)
                                .frame(maxWidth: .infinity)
                                .background(Color(.systemGray6))
                                .cornerRadius(12)
                            }
                        }
                    }
                }
                .padding(.horizontal, 20)
                
                Spacer()
            }
        }
    }
}

struct CompleteStepView: View {
    @ObservedObject var viewModel: OnboardingViewModel
    
    var body: some View {
        VStack(spacing: 30) {
            Spacer()
            
            Image(systemName: "checkmark.circle.fill")
                .font(.system(size: 120))
                .foregroundColor(.green)
            
            Text("You're all set!")
                .font(.system(size: 36, weight: .bold))
            
            Text("Start finding your perfect match")
                .font(.title3)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 40)
            
            Spacer()
        }
    }
}
