import SwiftUI
import CoreLocation

struct LocationPermissionStepView: View {
    @ObservedObject var viewModel: OnboardingViewModel
    @StateObject private var locationService = LocationService.shared
    
    var body: some View {
        VStack(spacing: 30) {
            Spacer()
            
            Image(systemName: "location.fill.viewfinder")
                .font(.system(size: 100))
                .foregroundColor(.blue)
            
            Text("Enable Location Services")
                .font(.title.bold())
                .multilineTextAlignment(.center)
            
            Text("We'll use your location to find matches nearby. Your exact location is never shared.")
                .font(.body)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 40)
            
            VStack(spacing: 16) {
                FeatureRow(
                    icon: "mappin.circle.fill",
                    text: "Find matches near you",
                    color: .blue
                )
                FeatureRow(
                    icon: "shield.fill",
                    text: "Your privacy is protected",
                    color: .green
                )
                FeatureRow(
                    icon: "slider.horizontal.3",
                    text: "Control your distance range",
                    color: .purple
                )
            }
            .padding(.horizontal, 40)
            
            if locationService.authorizationStatus == .authorizedWhenInUse ||
               locationService.authorizationStatus == .authorizedAlways {
                VStack(spacing: 12) {
                    Image(systemName: "checkmark.circle.fill")
                        .font(.system(size: 50))
                        .foregroundColor(.green)
                    Text("Location Enabled")
                        .font(.headline)
                        .foregroundColor(.green)
                }
            } else {
                PrimaryButton(title: "Enable Location") {
                    locationService.requestPermission()
                }
                .padding(.horizontal, 40)
                
                Button("Maybe Later") {
                    // Skip logic
                }
                .foregroundColor(.secondary)
            }
            
            Spacer()
        }
    }
}

private struct FeatureRow: View {
    let icon: String
    let text: String
    let color: Color
    
    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: icon)
                .font(.title2)
                .foregroundColor(color)
                .frame(width: 30)
            Text(text)
                .font(.body)
            Spacer()
        }
    }
}
