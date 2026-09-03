import Foundation
import MapKit

struct MapKitPlaceService {

    private static let sibiuCenter = CLLocationCoordinate2D(
        latitude: 45.7966,
        longitude: 24.1517
    )

    static func fetchPlaces(
        for category: PlaceCategory
    ) async throws -> [Place] {

        let mapKitCategory: MKPointOfInterestCategory

        switch category {
        case .restaurant:
            mapKitCategory = .restaurant

        case .cafe:
            mapKitCategory = .cafe

        default:
            return []
        }

        let request = MKLocalPointsOfInterestRequest(
            center: sibiuCenter,
            radius: 4_000
        )

        request.pointOfInterestFilter = MKPointOfInterestFilter(
            including: [
                mapKitCategory
            ]
        )

        let search = MKLocalSearch(request: request)
        let response = try await search.start()

        return response.mapItems.compactMap { item in
            makePlace(from: item)
        }
    }

    private static func makePlace(
        from item: MKMapItem
    ) -> Place? {

        guard let name = item.name,
              let category = category(
                from: item.pointOfInterestCategory
              ) else {
            return nil
        }

        let coordinate = item.location.coordinate

        let id = item.identifier?.rawValue
            ?? "mapkit-\(name)-\(coordinate.latitude)-\(coordinate.longitude)"

        return Place(
            id: id,
            name: name,
            description: description(for: category),
            category: category,
            latitude: coordinate.latitude,
            longitude: coordinate.longitude,
            address: item.address?.fullAddress ?? "Sibiu",
            imageName: nil,
            rating: nil,
            isFeatured: false,
            status: nil
        )
    }

    private static func category(
        from mapCategory: MKPointOfInterestCategory?
    ) -> PlaceCategory? {

        switch mapCategory {
        case .restaurant:
            return .restaurant

        case .cafe:
            return .cafe

        default:
            return nil
        }
    }

    private static func description(
        for category: PlaceCategory
    ) -> String {

        switch category {
        case .restaurant:
            return "Restaurant din Sibiu."

        case .cafe:
            return "Cafenea din Sibiu."

        default:
            return "Loc din Sibiu."
        }
    }
}
