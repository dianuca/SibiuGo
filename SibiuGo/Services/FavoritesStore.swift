import Foundation
import Observation

@Observable
final class FavoritesStore {
    private(set) var favoriteIDs: Set<String>

    private let userDefaultsKey = "favoritePlaceIDs"

    init() {
        let savedIDs = UserDefaults.standard.stringArray(
            forKey: userDefaultsKey
        ) ?? []

        favoriteIDs = Set(savedIDs)
    }

    func isFavorite(_ place: Place) -> Bool {
        favoriteIDs.contains(place.id)
    }

    func toggle(_ place: Place) {
        if isFavorite(place) {
            favoriteIDs.remove(place.id)
        } else {
            favoriteIDs.insert(place.id)
        }

        save()
    }

    private func save() {
        UserDefaults.standard.set(
            Array(favoriteIDs),
            forKey: userDefaultsKey
        )
    }
}
