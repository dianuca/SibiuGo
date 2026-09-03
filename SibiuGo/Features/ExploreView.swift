//
//  ExploreView.swift
//  SibiuGo
//
//  Created by Diana Ciodolan on 03/09/2026.
//

import SwiftUI
import MapKit

struct ExploreView: View {
    private let localPlaces = PlaceService.places
    @State private var mapKitPlaces: [Place] = []
    private var places: [Place] {
        localPlaces + mapKitPlaces
    }
    @State private var selectedCategory: PlaceCategory?
    @State private var searchText = ""
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
    
    private func loadMapKitPlaces() async {
        guard mapKitPlaces.isEmpty else {
            return
        }

        do {
            mapKitPlaces = try await MapKitPlaceService
                .fetchFoodPlaces()
        } catch {
            print(
                "MapKit places error: \(error.localizedDescription)"
            )
        }
    }
    
    private var filteredPlaces: [Place] {
        var result = places

        if let selectedCategory {
            result = result.filter {
                $0.category == selectedCategory
            }
        }

        let trimmedSearchText = searchText
            .trimmingCharacters(in: .whitespacesAndNewlines)

        if !trimmedSearchText.isEmpty {
            result = result.filter { place in
                place.name.localizedCaseInsensitiveContains(trimmedSearchText)
                || place.address.localizedCaseInsensitiveContains(trimmedSearchText)
                || place.category.title.localizedCaseInsensitiveContains(trimmedSearchText)
            }
        }

        return result
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
            PlaceImageView(
                place: place,
                width: 90,
                height: 90
            )

            VStack(alignment: .leading, spacing: 6) {
                Text(place.name)
                    .font(.headline)

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
                    if let distance = locationService.distance(to: place) {
                        if place.rating != nil {
                            Text("•")
                        }
                        Text(distanceText(distance))
                    }
                }
                .font(.caption)
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
            .task {
                await loadMapKitPlaces()
            }
            .navigationTitle("Explorează")
            .navigationBarTitleDisplayMode(.inline)
            .searchable(
                text: $searchText,
                prompt: "Caută un loc în Sibiu"
            )
            .onChange(of: searchText) {
                selectedPlaceID = nil
            }
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
