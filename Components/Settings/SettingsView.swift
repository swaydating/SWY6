import SwiftUI

struct SettingsView: View {
    @State private var notificationsEnabled = true
    @State private var showOnlineStatus = true
    @State private var distanceUnit = "Miles"
    
    var body: some View {
        Form {
            Section("Account") {
                NavigationLink(destination: Text("Account Details")) {
                    SettingsRow(icon: "person.circle.fill", title: "Account Details", color: .blue)
                }
                NavigationLink(destination: Text("Privacy")) {
                    SettingsRow(icon: "lock.fill", title: "Privacy", color: .green)
                }
                NavigationLink(destination: Text("Blocked Users")) {
                    SettingsRow(icon: "hand.raised.fill", title: "Blocked Users", color: .red)
                }
            }
            
            Section("Preferences") {
                Toggle(isOn: $notificationsEnabled) {
                    HStack {
                        Image(systemName: "bell.fill")
                            .foregroundColor(.orange)
                            .frame(width: 30)
                        Text("Notifications")
                    }
                }
                
                Toggle(isOn: $showOnlineStatus) {
                    HStack {
                        Image(systemName: "circle.fill")
                            .foregroundColor(.green)
                            .frame(width: 30)
                        Text("Show Online Status")
                    }
                }
                
                Picker("Distance Unit", selection: $distanceUnit) {
                    Text("Miles").tag("Miles")
                    Text("Kilometers").tag("Kilometers")
                }
            }
            
            Section("Discovery") {
                NavigationLink(destination: Text("Discovery Preferences")) {
                    SettingsRow(icon: "sparkles", title: "Discovery Preferences", color: .purple)
                }
                NavigationLink(destination: Text("Location")) {
                    SettingsRow(icon: "location.fill", title: "Location", color: .blue)
                }
            }
            
            Section("Support") {
                NavigationLink(destination: Text("Help & Support")) {
                    SettingsRow(icon: "questionmark.circle.fill", title: "Help & Support", color: .blue)
                }
                NavigationLink(destination: Text("Safety Tips")) {
                    SettingsRow(icon: "shield.fill", title: "Safety Tips", color: .green)
                }
                NavigationLink(destination: Text("Terms & Conditions")) {
                    SettingsRow(icon: "doc.text.fill", title: "Terms & Conditions", color: .gray)
                }
            }
            
            Section("About") {
                HStack {
                    Text("Version")
                    Spacer()
                    Text("1.0.0")
                        .foregroundColor(.secondary)
                }
            }
        }
        .navigationTitle("Settings")
        .navigationBarTitleDisplayMode(.inline)
    }
}
