import SwiftUI

struct MainTabView: View {
    @State private var selectedTab = 0
    
    var body: some View {
        TabView(selection: $selectedTab) {
            MatchingView()
                .tabItem {
                    Label("Discover", systemImage: "flame.fill")
                }
                .tag(0)
            
            ChatListView()
                .tabItem {
                    Label("Messages", systemImage: "message.fill")
                }
                .tag(1)
            
            ProfileView()
                .tabItem {
                    Label("Profile", systemImage: "person.fill")
                }
                .tag(2)
        }
        .accentColor(.pink)
    }
}
