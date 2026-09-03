//
//  ExploreView.swift
//  SibiuGo
//
//  Created by Diana Ciodolan on 03/09/2026.
//

import SwiftUI
import MapKit

struct ExploreView: View {
    private let places = PlaceService.places
    
    @State private var selectedCategory: PlaceCategory?
    @State private var selectedPlaceID: String?
    @Environment(LocationService.self) private var locationService
    @State private var position: MapCameraPosition = .region(
        MKCoordinateRegion(
            center: CLLocationCoordinate2D(
                latitude: 45.7983,
                longitude: 24.1256
            ),
            span: MKCoordinateSpan(
                latitudeDelta: 0.08,
                longitudeDelta: 0.08
            )
        )
    )

    private var selectedPlace: Place? {
        places.first { $0.id == selectedPlaceID }
    }
    private var filteredPlaces: [Place] {
        guard let selectedCategory else {
            return places
        }

        return places.filter {
            $0.category == selectedCategory
        }
    }
    private var availableCategories: [PlaceCategory] {
        PlaceCategory.allCases.filter { category in
            places.contains {
                $0.category == category
            }
        }
    }
    private var categoryFilters: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 10) {
                Button {
                    selectedCategory = nil
                    selectedPlaceID = nil
                } label: {
                    Label(
                        "Toate",
                        systemImage: "map"
                    )
                    .font(.subheadline)
                    .fontWeight(.medium)
                    .padding(.horizontal, 14)
                    .padding(.vertical, 9)
                    .background(
                        selectedCategory == nil
                            ? Color.accentColor
                            : Color(.systemBackground)
                    )
                    .foregroundStyle(
                        selectedCategory == nil
                            ? .white
                            : .primary
                    )
                    .clipShape(Capsule())
                }

                ForEach(availableCategories) { category in
                    Button {
                        selectedCategory = category
                        selectedPlaceID = nil
                    } label: {
                        Label(
                            category.title,
                            systemImage: category.icon
                        )
                        .font(.subheadline)
                        .fontWeight(.medium)
                        .padding(.horizontal, 14)
                        .padding(.vertical, 9)
                        .background(
                            selectedCategory == category
                                ? Color.accentColor
                                : Color(.systemBackground)
                        )
                        .foregroundStyle(
                            selectedCategory == category
                                ? .white
                                : .primary
                        )
                        .clipShape(Capsule())
                    }
                }
            }
            .padding(.horizontal)
            .padding(.vertical, 8)
        }
        .background(.ultraThinMaterial)
    }
    private func distanceText(
        _ distance: CLLocationDistance
    ) -> String {
        if distance < 1000 {
            return "\(Int(distance)) m"
        }

        return String(
            format: "%.1f km",
            distance / 1000
        )
    }
    private func selectedPlaceCard(_ place: Place) -> some View {
        HStack(spacing: 14) {
            Image(place.imageName)
                .resizable()
                .scaledToFill()
                .frame(width: 90, height: 90)
                .clipShape(
                    RoundedRectangle(cornerRadius: 14)
                )

            VStack(alignment: .leading, spacing: 6) {
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

                    if let distance = locationService.distance(to: place) {
                        Text("•")

                        Text(distanceText(distance))
                    }
                }
                .font(.caption)

                NavigationLink {
                    PlaceDetailsView(place: place)
                } label: {
                    Text("Vezi detalii")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                }
            }

            Spacer()

            Button {
                selectedPlaceID = nil
            } label: {
                Image(systemName: "xmark.circle.fill")
                    .font(.title2)
                    .foregroundStyle(.secondary)
            }
        }
        .padding()
        .background(.ultraThinMaterial)
        .clipShape(
            RoundedRectangle(cornerRadius: 20)
        )
    }
    var body: some View {
        NavigationStack {
            Map(
                position: $position,
                selection: $selectedPlaceID
            ) {
                UserAnnotation()
                ForEach(filteredPlaces) { place in
                    Marker(
                        place.name,
                        coordinate: CLLocationCoordinate2D(
                            latitude: place.latitude,
                            longitude: place.longitude
                        )
                    )
                    .tag(place.id)
                }
            }
            .mapControls {
                MapUserLocationButton()
                MapCompass()
            }
            .onAppear {
                locationService.requestPermission()
            }
            .navigationTitle("Explorează")
            .navigationBarTitleDisplayMode(.inline)
            .safeAreaInset(edge: .top) {
                categoryFilters
            }
            .safeAreaInset(edge: .bottom) {
                if let selectedPlace {
                    selectedPlaceCard(selectedPlace)
                        .padding()
                }
            }
        }
    }
}

#Preview {
    ExploreView()
        .environment(LocationService())
        .environment(FavoritesStore())
}
