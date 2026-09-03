import Foundation

struct PlaceService {
    static let places: [Place] = loadPlaces()

    private static func loadPlaces() -> [Place] {
        guard let url = Bundle.main.url(
            forResource: "places",
            withExtension: "json"
        ) else {
            print("Could not find places.json")
            return []
        }

        do {
            let data = try Data(contentsOf: url)

            return try JSONDecoder().decode(
                [Place].self,
                from: data
            )
        } catch {
            print("Could not load places: \(error)")
            return []
        }
    }
}
