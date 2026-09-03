import SwiftUI

struct RootView: View {
    var body: some View {
        TabView {
            Tab("Acasă", systemImage: "house.fill") {
                HomeView()
            }

            Tab("Explorează", systemImage: "map.fill") {
                ExploreView()
            }

            Tab("Evenimente", systemImage: "calendar") {
                EventsView()
            }

            Tab("Salvate", systemImage: "heart.fill") {
                SavedView()
            }
        }
    }
}

#Preview {
    RootView()
        .environment(FavoritesStore())
        .environment(LocationService())
}
