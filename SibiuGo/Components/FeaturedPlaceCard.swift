import SwiftUI
import CoreLocation

struct FeaturedPlaceCard: View {
    let place: Place
    let distance: CLLocationDistance?

    private var distanceText: String? {
        guard let distance else {
            return nil
        }

        if distance < 1000 {
            return "\(Int(distance)) m"
        }

        return String(
            format: "%.1f km",
            distance / 1000
        )
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Image(place.imageName)
                .resizable()
                .scaledToFill()
                .frame(width: 270, height: 170)
                .clipped()
                .clipShape(
                    RoundedRectangle(cornerRadius: 18)
                )

            Text(place.name)
                .font(.headline)

            Text(place.category.title)
                .font(.subheadline)
                .foregroundStyle(.secondary)

            HStack(spacing: 5) {
                Image(systemName: "star.fill")

                Text(
                    String(
                        format: "%.1f",
                        place.rating
                    )
                )

                if let distanceText {
                    Text("•")
                    Text(distanceText)
                }
            }
            .font(.caption)
        }
        .frame(width: 270, alignment: .leading)
    }
}
