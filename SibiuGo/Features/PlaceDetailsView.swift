//
//  PlaceDetailsView.swift
//  SibiuGo
//
//  Created by Diana Ciodolan on 03/09/2026.
//

import SwiftUI
import MapKit

struct PlaceDetailsView: View {
    let place: Place
    @Environment(FavoritesStore.self) private var favoritesStore
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Image(place.imageName)
                    .resizable()
                    .scaledToFill()
                    .frame(height: 260)
                    .frame(maxWidth: .infinity)
                    .clipped()

                VStack(alignment: .leading, spacing: 16) {
                    Text(place.name)
                        .font(.largeTitle)
                        .fontWeight(.bold)

                    Label(
                        place.category.title,
                        systemImage: place.category.icon
                    )
                    .foregroundStyle(.secondary)
                    if let status = place.status {
                        Label(
                            status.title,
                            systemImage: status.icon
                        )
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .foregroundStyle(
                            status == .temporarilyClosed
                                ? .orange
                                : .green
                        )
                    }

                    HStack(spacing: 5) {
                        Image(systemName: "star.fill")

                        Text(
                            String(
                                format: "%.1f",
                                place.rating
                            )
                        )
                    }

                    Divider()

                    Text("Despre")
                        .font(.title2)
                        .fontWeight(.semibold)

                    Text(place.description)

                    Divider()

                    Text("Adresă")
                        .font(.title2)
                        .fontWeight(.semibold)

                    Label(
                        place.address,
                        systemImage: "mappin.and.ellipse"
                    )
                    Button {
                        openInMaps()
                    } label: {
                        Label(
                            "Deschide în Maps",
                            systemImage: "map.fill"
                        )
                        .frame(maxWidth: .infinity)
                    }
                    .buttonStyle(.borderedProminent)
                }
                .padding()
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    favoritesStore.toggle(place)
                } label: {
                    Image(
                        systemName: favoritesStore.isFavorite(place)
                            ? "heart.fill"
                            : "heart"
                    )
                }
            }
        }
    }
    private func openInMaps() {
        let coordinate = CLLocationCoordinate2D(
            latitude: place.latitude,
            longitude: place.longitude
        )

        let mapItem = MKMapItem(
            location: CLLocation(
                latitude: coordinate.latitude,
                longitude: coordinate.longitude
            ),
            address: nil
        )

        mapItem.name = place.name

        mapItem.openInMaps()
    }
}

#Preview {
    NavigationStack {
        PlaceDetailsView(
            place: PlaceService.places[0]
        )
    }
    .environment(FavoritesStore())
}
