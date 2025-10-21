//\
//  UserOnboardingData.swift
//  SWY6
//
//  Created on 2025-10-21
//\

import Foundation

struct UserOnboardingData: Codable {
    // Cultural & Language
    var culturalBackground: String = ""
    var languages: [String] = []
    
    // Food Preferences
    var cuisines: [String] = []
    var dishes: [String] = []
    var drinks: [String] = []
    var dietaryPreferences: [String] = []
    
    // Personal Background
    var birthplace: String = ""
    var placesLived: [PlaceStay] = []
    
    // Appearance & Style
    var styles: [String] = []
    var wearsJewellery: Bool?
    var jewelleryTypes: [String] = []
    var hasTattoos: Bool?
    var skincareInterest: Bool?
    var fashionPassionate: Bool?
    
    // Personality
    var personalityKeywords: [String] = []
    var talkTopics: [String] = []
    var coreTraits: [String] = []
    var isMessy: Bool?
    var loveSurprises: Bool?
    var quirkyUnique: Bool?
    var socialEnergy: String?
    
    // Date Night
    var dateOutfits: [String] = []
    var dateVenues: [String] = []
    var dateVibe: String?
    var perfectDateDescription: String = ""
    
    // Lifestyle
    var favouriteDay: String?
    var favouriteSeason: String?
    var favouriteWeather: String?
    var favouriteTimeOfDay: String?
    
    // Sports
    var sports: [String] = []
    var sportDetails: [String: SportDetail] = [:]
    
    // Hobbies & Skills
    var hobbies: [String] = []
    var hobbyLevels: [String: String] = [:]
    var cosplay: Bool?
    var memesHumour: Bool?
    var adrenalineStuff: Bool?
    
    // Political Stance
    var isPolitical: Bool?
    var politicalStance: String?
    var discussionPreference: String?
    
    // Movie Preferences
    var favouriteTVShows: [String] = []
    var favouriteMovies: [String] = []
    
    // Causes
    var cause: String?
    var causeInvolvement: String = ""
    
    // Music Preferences
    var musicGenre: String?
    var musicSubgenres: [String] = []
    var favouriteArtists: [String] = []
    var karaoke: Bool?
    
    // Locations & Travel
    var travelVibes: [String] = []
    var longDistancePreference: String?
    var timeZoneComfort: String?
    var favouriteHoliday: String = ""
    var dreamDestination: String = ""
    
    // Outdoor Activities
    var outdoorActivity: String?
    var outdoorLevel: String?
    
    // Going Out
    var goingOutFrequency: String?
    var goingOutDistance: String?
    var goingOutActivities: [String] = []
    
    // Staying In
    var stayingInActivities: [String] = []
    
    // Fan Favourites
    var leagues: [String] = []
    var fandoms: [String] = []
    var teamsByLeague: [String: String] = [:]
    var playersByLeague: [String: String] = [:]
    
    // Social Media
    var usesSocialMedia: Bool?
    var socialMediaRole: String?
    var socialMediaFrequency: String?
    
    // Gaming
    var gamingPlatforms: [String] = []
    var favouriteGame: String?
}

struct PlaceStay: Identifiable, Codable, Hashable {
    let id = UUID()
    var name: String
    var durationMonths: Int
}

struct SportDetail: Codable {
    var playOrWatch: String
    var frequency: String?
    var position: String?
}

struct SelectedLanguage: Identifiable, Codable {
    let id = UUID()
    var name: String
    var level: String?
}