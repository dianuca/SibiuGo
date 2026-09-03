import SwiftUI
import CoreLocation

struct PlaceRowView: View {
    let place: Place
    let distance: CLLocationDistance?

    init(
        place: Place,
        distance: CLLocationDistance? = nil
    ) {
        self.place = place
        self.distance = distance
    }

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
        HStack(spacing: 16) {
            Image(systemName: place.category.icon)
                .font(.title2)
                .frame(width: 55, height: 55)
                .background(.thinMaterial)
                .clipShape(
                    RoundedRectangle(cornerRadius: 14)
                )

            VStack(alignment: .leading, spacing: 5) {
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

            Spacer()

            Image(systemName: "chevron.right")
                .font(.caption)
                .foregroundStyle(.secondary)
        }
        .padding(.vertical, 6)
    }
}
