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
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    headerSection
                    categoriesSection
                    featuredSection
                }
                .padding()
            }
            .navigationTitle("SibiuGo")
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
                    PlaceRowView(place: place)
                }
                .buttonStyle(.plain)

                Divider()
            }
        }
    }
    
    private var filteredPlaces: [Place] {
        if let selectedCategory {
            return places.filter {
                $0.category == selectedCategory
            }
        }

        return places.filter {
            $0.isFeatured
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
}
