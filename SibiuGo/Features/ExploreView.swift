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

    @State private var selectedPlaceID: UUID?

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

    var body: some View {
        NavigationStack {
            Map(
                position: $position,
                selection: $selectedPlaceID
            ) {
                ForEach(places) { place in
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
            .navigationTitle("Explorează")
            .navigationBarTitleDisplayMode(.inline)
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
}
