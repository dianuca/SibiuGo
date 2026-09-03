import SwiftUI

struct SavedView: View {

    @Environment(FavoritesStore.self) private var favoritesStore

    private var savedPlaces: [Place] {
        PlaceService.places.filter {
            favoritesStore.isFavorite($0)
        }
    }

    var body: some View {
        NavigationStack {
            Group {
                if savedPlaces.isEmpty {
                    ContentUnavailableView(
                        "Niciun loc salvat",
                        systemImage: "heart",
                        description: Text(
                            "Locurile salvate vor apărea aici."
                        )
                    )
                } else {
                    List(savedPlaces) { place in
                        NavigationLink {
                            PlaceDetailsView(place: place)
                        } label: {
                            PlaceRowView(place: place)
                        }
                    }
                    .listStyle(.plain)
                }
            }
            .navigationTitle("Salvate")
        }
    }
}

#Preview {
    SavedView()
        .environment(FavoritesStore())
}
