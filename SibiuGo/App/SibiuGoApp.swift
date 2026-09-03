import SwiftUI

@main
struct SibiuGoApp: App {
    @State private var favoritesStore = FavoritesStore()

    var body: some Scene {
        WindowGroup {
            RootView()
                .environment(favoritesStore)
        }
    }
}
