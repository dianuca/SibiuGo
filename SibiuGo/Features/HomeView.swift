//
//  HomeView.swift
//  SibiuGo
//
//  Created by Diana Ciodolan on 03/09/2026.
//

import SwiftUI

struct HomeView: View {
    private let places = PlaceService.places

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    headerSection

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

            ForEach(
                places.filter { $0.isFeatured }
            ) { place in
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
}

#Preview {
    HomeView()
}
