import SwiftUI

struct HobbiesStepView: View {
    @ObservedObject var viewModel: OnboardingViewModel
    @State private var selectedHobbies: Set<String> = []
    
    let hobbies = [
        "Reading", "Writing", "Painting", "Drawing", "Photography",
        "Cooking", "Baking", "Gardening", "DIY Projects", "Crafts",
        "Gaming", "Board Games", "Video Games", "Collecting",
        "Volunteering", "Learning Languages", "Puzzles"
    ]
    
    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                Image(systemName: "paintbrush.fill")
                    .font(.system(size: 60))
                    .foregroundColor(.purple)
                    .padding(.top, 40)
                
                Text("What are your hobbies?")
                    .font(.title.bold())
                
                Text("Select all that apply")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 100))], spacing: 12) {
                    ForEach(hobbies, id: \.self) { hobby in
                        InterestTag(
                            title: hobby,
                            isSelected: selectedHobbies.contains(hobby)
                        ) {
                            if selectedHobbies.contains(hobby) {
                                selectedHobbies.remove(hobby)
                            } else {
                                selectedHobbies.insert(hobby)
                            }
                        }
                    }
                }
                .padding(.horizontal, 20)
            }
        }
    }
}

struct MusicStepView: View {
    @ObservedObject var viewModel: OnboardingViewModel
    @State private var selectedGenres: Set<String> = []
    
    let genres = [
        "Pop", "Rock", "Hip Hop", "R&B", "Country", "Jazz",
        "Classical", "Electronic", "Indie", "Alternative",
        "Metal", "Blues", "Reggae", "Latin", "K-Pop"
    ]
    
    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                Image(systemName: "music.note")
                    .font(.system(size: 60))
                    .foregroundColor(.pink)
                    .padding(.top, 40)
                
                Text("What music do you like?")
                    .font(.title.bold())
                
                Text("Select your favorite genres")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 100))], spacing: 12) {
                    ForEach(genres, id: \.self) { genre in
                        InterestTag(
                            title: genre,
                            isSelected: selectedGenres.contains(genre)
                        ) {
                            if selectedGenres.contains(genre) {
                                selectedGenres.remove(genre)
                            } else {
                                selectedGenres.insert(genre)
                            }
                        }
                    }
                }
                .padding(.horizontal, 20)
            }
        }
    }
}

struct MoviesStepView: View {
    @ObservedObject var viewModel: OnboardingViewModel
    @State private var selectedGenres: Set<String> = []
    
    let genres = [
        "Action", "Comedy", "Drama", "Horror", "Thriller",
        "Romance", "Sci-Fi", "Fantasy", "Documentary",
        "Animation", "Mystery", "Crime", "Adventure"
    ]
    
    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                Image(systemName: "film.fill")
                    .font(.system(size: 60))
                    .foregroundColor(.orange)
                    .padding(.top, 40)
                
                Text("What movies do you like?")
                    .font(.title.bold())
                
                Text("Select your favorite genres")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 100))], spacing: 12) {
                    ForEach(genres, id: \.self) { genre in
                        InterestTag(
                            title: genre,
                            isSelected: selectedGenres.contains(genre)
                        ) {
                            if selectedGenres.contains(genre) {
                                selectedGenres.remove(genre)
                            } else {
                                selectedGenres.insert(genre)
                            }
                        }
                    }
                }
                .padding(.horizontal, 20)
            }
        }
    }
}

struct BooksStepView: View {
    @ObservedObject var viewModel: OnboardingViewModel
    @State private var selectedGenres: Set<String> = []
    
    let genres = [
        "Fiction", "Non-Fiction", "Mystery", "Thriller",
        "Romance", "Sci-Fi", "Fantasy", "Biography",
        "History", "Self-Help", "Business", "Poetry"
    ]
    
    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                Image(systemName: "book.fill")
                    .font(.system(size: 60))
                    .foregroundColor(.green)
                    .padding(.top, 40)
                
                Text("What books do you like?")
                    .font(.title.bold())
                
                Text("Select your favorite genres")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 100))], spacing: 12) {
                    ForEach(genres, id: \.self) { genre in
                        InterestTag(
                            title: genre,
                            isSelected: selectedGenres.contains(genre)
                        ) {
                            if selectedGenres.contains(genre) {
                                selectedGenres.remove(genre)
                            } else {
                                selectedGenres.insert(genre)
                            }
                        }
                    }
                }
                .padding(.horizontal, 20)
            }
        }
    }
}

struct SportsStepView: View {
    @ObservedObject var viewModel: OnboardingViewModel
    @State private var selectedSports: Set<String> = []
    
    let sports = [
        "Football", "Basketball", "Baseball", "Soccer",
        "Tennis", "Golf", "Swimming", "Running", "Cycling",
        "Hiking", "Yoga", "Gym", "Boxing", "Martial Arts",
        "Volleyball", "Hockey", "Skiing", "Surfing"
    ]
    
    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                Image(systemName: "sportscourt.fill")
                    .font(.system(size: 60))
                    .foregroundColor(.blue)
                    .padding(.top, 40)
                
                Text("What sports do you like?")
                    .font(.title.bold())
                
                Text("Select all that apply")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 100))], spacing: 12) {
                    ForEach(sports, id: \.self) { sport in
                        InterestTag(
                            title: sport,
                            isSelected: selectedSports.contains(sport)
                        ) {
                            if selectedSports.contains(sport) {
                                selectedSports.remove(sport)
                            } else {
                                selectedSports.insert(sport)
                            }
                        }
                    }
                }
                .padding(.horizontal, 20)
            }
        }
    }
}
