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
            .sheet(
                isPresented: Binding(
                    get: {
                        selectedPlace != nil
                    },
                    set: { isPresented in
                        if !isPresented {
                            selectedPlaceID = nil
                        }
                    }
                )
            ) {
                if let selectedPlace {
                    NavigationStack {
                        PlaceDetailsView(
                            place: selectedPlace
                        )
                    }
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
