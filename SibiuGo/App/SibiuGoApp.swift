import SwiftUI

@main
struct SibiuGoApp: App {
    @State private var favoritesStore = FavoritesStore()
    @State private var locationService = LocationService()

    var body: some Scene {
        WindowGroup {
            RootView()
                .environment(favoritesStore)
                .environment(locationService)
        }
    }
}
