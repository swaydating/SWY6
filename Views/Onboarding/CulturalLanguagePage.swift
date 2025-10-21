//
//  CulturalLanguagePage.swift
//  SWY6
//
//  Created on 2025-10-21
//

import SwiftUI

struct CulturalLanguagePage: View {
    @Binding var step: OnboardingStep
    @Binding var data: UserOnboardingData
    
    @State private var cultureSearch = ""
    @State private var languageSearch = ""
    @State private var selectedLanguages: [SelectedLanguage] = []
    @State private var showingLevelPicker: SelectedLanguage?
    
    private var canContinue: Bool {
        !data.culturalBackground.trimmed.isEmpty && !selectedLanguages.isEmpty
    }
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            
            VStack(spacing: 24) {
                StepHeader(step: $step, showBack: false, showHelp: true)
                
                ScrollView {
                    VStack(alignment: .leading, spacing: 24) {
                        Text("Cultural & Language")
                            .font(.largeTitle.weight(.bold))
                            .foregroundColor(.white)
                        
                        Text("Let's start with your background")
                            .font(.title3)
                            .foregroundColor(.white.opacity(0.7))
                        
                        VStack(alignment: .leading, spacing: 12) {
                            Text("What's your cultural background?")
                                .font(.headline)
                                .foregroundColor(.white)
                            
                            TextField("e.g., British, Indian, Nigerian", text: $data.culturalBackground)
                                .padding()
                                .background(Color.white.opacity(0.1))
                                .cornerRadius(12)
                                .foregroundColor(.white)
                            
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack(spacing: 8) {
                                    ForEach(defaultCultureSuggestions, id: \.self) { culture in
                                        Button {
                                            data.culturalBackground = culture
                                        } label: {
                                            Text(culture)
                                                .font(.caption.weight(.semibold))
                                                .foregroundColor(.white)
                                                .padding(.horizontal, 12)
                                                .padding(.vertical, 6)
                                        }
                                        .buttonStyle(RedSelectableChipStyle(selected: data.culturalBackground == culture))
                                    }
                                }
                            }
                        }
                        
                        VStack(alignment: .leading, spacing: 12) {
                            Text("What languages do you speak?")
                                .font(.headline)
                                .foregroundColor(.white)
                            
                            TextField("Search languages...", text: $languageSearch)
                                .padding()
                                .background(Color.white.opacity(0.1))
                                .cornerRadius(12)
                                .foregroundColor(.white)
                            
                            if !selectedLanguages.isEmpty {
                                VStack(spacing: 8) {
                                    ForEach(selectedLanguages) { lang in
                                        HStack {
                                            Text(lang.name)
                                                .foregroundColor(.white)
                                            Spacer()
                                            if let level = lang.level {
                                                Text(level)
                                                    .font(.caption)
                                                    .foregroundColor(.white.opacity(0.7))
                                            }
                                            Button {
                                                showingLevelPicker = lang
                                            } label: {
                                                Text("Set Level")
                                                    .font(.caption)
                                                    .foregroundColor(.red)
                                            }
                                            Button {
                                                selectedLanguages.removeAll { $0.id == lang.id }
                                            } label: {
                                                Image(systemName: "xmark.circle.fill")
                                                    .foregroundColor(.red)
                                            }
                                        }
                                        .padding()
                                        .background(Color.white.opacity(0.1))
                                        .cornerRadius(8)
                                    }
                                }
                            }
                            
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack(spacing: 8) {
                                    ForEach(defaultLanguageSuggestions, id: \.self) { language in
                                        Button {
                                            if !selectedLanguages.contains(where: { $0.name == language }) {
                                                selectedLanguages.append(SelectedLanguage(name: language, level: nil))
                                            }
                                        } label: {
                                            Text(language)
                                                .font(.caption.weight(.semibold))
                                                .foregroundColor(.white)
                                                .padding(.horizontal, 12)
                                                .padding(.vertical, 6)
                                        }
                                        .buttonStyle(RedSelectableChipStyle(selected: selectedLanguages.contains(where: { $0.name == language })))
                                    }
                                }
                            }
                        }
                    }
                    .padding()
                }
                
                VStack(spacing: 12) {
                    primaryButton("Continue", enabled: canContinue) {
                        data.languages = selectedLanguages.map { $0.name }
                        step.advance()
                    }
                    
                    RedOutlineSkipButton {
                        step.advance()
                    }
                }
                .padding()
            }
        }
        .sheet(item: $showingLevelPicker) { lang in
            LanguageLevelPicker(language: lang, selectedLanguages: $selectedLanguages)
        }
    }
}

struct LanguageLevelPicker: View {
    let language: SelectedLanguage
    @Binding var selectedLanguages: [SelectedLanguage]
    @Environment(\ .dismiss) var dismiss
    
    private let levels = ["Beginner", "Conversational", "Fluent", "Native"]
    
    var body: some View {
        NavigationView {
            List(levels, id: \.self) { level in
                Button {
                    if let index = selectedLanguages.firstIndex(where: { $0.id == language.id }) {
                        selectedLanguages[index] = SelectedLanguage(name: language.name, level: level)
                    }
                    dismiss()
                } label: {
                    HStack {
                        Text(level)
                        Spacer()
                        if language.level == level {
                            Image(systemName: "checkmark")
                                .foregroundColor(.red)
                        }
                    }
                }
            }
            .navigationTitle("Select Level for \(language.name)")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}