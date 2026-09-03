//
//  HomeView.swift
//  SibiuGo
//
//  Created by Diana Ciodolan on 03/09/2026.
//

import SwiftUI

struct HomeView: View {
    private let places = PlaceService.places
    @State private var selectedCategory: PlaceCategory?
    @State private var searchText = ""
    @Environment(LocationService.self) private var locationService
    @State private var isNearbyExpanded = false
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    headerSection
                    categoriesSection
                    featuredSection

                    if !nearbyPlaces.isEmpty {
                        nearbySection
                    }
                }
                .padding()
            }
            .navigationTitle("SibiuGo")
        }
        .searchable(
            text: $searchText,
            prompt: "Caută locuri în Sibiu"
        )
        .onAppear {
            locationService.requestLocation()
        }
    }

    private var headerSection: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text("Descoperă Sibiul")
                .font(.largeTitle)
                .fontWeight(.bold)

            Text("Locuri, evenimente și experiențe.")
                .foregroundStyle(.secondary)
        }
    }

    private var featuredSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Recomandate")
                .font(.title2)
                .fontWeight(.semibold)

            ForEach(filteredPlaces) { place in
                NavigationLink {
                    PlaceDetailsView(place: place)
                } label: {
                    PlaceRowView(
                        place: place,
                        distance: locationService.distance(to: place)
                    )
                }
                .buttonStyle(.plain)

                Divider()
            }
        }
    }
    
    private var filteredPlaces: [Place] {
        var result: [Place]

        if let selectedCategory {
            result = places.filter {
                $0.category == selectedCategory
            }
        } else {
            result = places.filter {
                $0.isFeatured
            }
        }

        if !searchText.isEmpty {
            result = places.filter {
                $0.name.localizedCaseInsensitiveContains(searchText)
            }
        }

        return result
    }
    
    private var nearbyPlaces: [Place] {
        guard locationService.currentLocation != nil else {
            return []
        }

        let sortedPlaces = places.sorted { firstPlace, secondPlace in
            let firstDistance =
                locationService.distance(to: firstPlace)
                ?? .greatestFiniteMagnitude

            let secondDistance =
                locationService.distance(to: secondPlace)
                ?? .greatestFiniteMagnitude

            return firstDistance < secondDistance
        }

        return Array(sortedPlaces.prefix(3))
    }
    
    private var nearbySection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Button {
                withAnimation {
                    isNearbyExpanded.toggle()
                }
            } label: {
                HStack {
                    Image(systemName: "location.fill")

                    Text("În apropiere")
                        .font(.title2)
                        .fontWeight(.semibold)

                    Spacer()

                    Image(
                        systemName: isNearbyExpanded
                            ? "chevron.up"
                            : "chevron.down"
                    )
                    .font(.caption)
                    .foregroundStyle(.secondary)
                }
            }
            .buttonStyle(.plain)

            if isNearbyExpanded {
                ForEach(nearbyPlaces) { place in
                    NavigationLink {
                        PlaceDetailsView(place: place)
                    } label: {
                        PlaceRowView(
                            place: place,
                            distance: locationService.distance(to: place)
                        )
                    }
                    .buttonStyle(.plain)

                    Divider()
                }
            }
        }
    }
    
    private var categoriesSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Categorii")
                .font(.title2)
                .fontWeight(.semibold)

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 16) {
                    ForEach(PlaceCategory.allCases) { category in
                        Button {
                            if selectedCategory == category {
                                selectedCategory = nil
                            } else {
                                selectedCategory = category
                            }
                        } label: {
                            CategoryButton(
                                category: category,
                                isSelected: selectedCategory == category
                            )
                        }
                        .buttonStyle(.plain)
                    }
                }
            }
        }
    }
}

#Preview {
    HomeView()
        .environment(LocationService())
        .environment(FavoritesStore())
}
