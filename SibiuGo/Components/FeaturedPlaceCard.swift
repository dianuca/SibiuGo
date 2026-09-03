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
        VStack(alignment: .leading, spacing: 0) {

            PlaceImageView(
                place: place,
                width: 280,
                height: 175,
                cornerRadius: 0
            )

            VStack(alignment: .leading, spacing: 7) {

                Text(place.name)
                    .font(.headline)
                    .lineLimit(1)

                Text(place.category.title)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)

                HStack(spacing: 5) {

                    if let rating = place.rating {
                        Image(systemName: "star.fill")

                        Text(
                            String(
                                format: "%.1f",
                                rating
                            )
                        )
                    }

                    if let distanceText {
                        if place.rating != nil {
                            Text("•")
                        }

                        Image(systemName: "location.fill")
                            .font(.caption2)

                        Text(distanceText)
                    }
                }
                .font(.caption)
                .foregroundStyle(.secondary)
            }
            .padding(14)
        }
        .frame(width: 280)
        .background(.background)
        .clipShape(
            RoundedRectangle(
                cornerRadius: 18,
                style: .continuous
            )
        )
        .overlay {
            RoundedRectangle(
                cornerRadius: 18,
                style: .continuous
            )
            .stroke(
                Color.secondary.opacity(0.15),
                lineWidth: 1
            )
        }
    }
}
