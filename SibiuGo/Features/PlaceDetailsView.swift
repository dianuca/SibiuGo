//
//  PlaceDetailsView.swift
//  SibiuGo
//
//  Created by Diana Ciodolan on 03/09/2026.
//

import SwiftUI

struct PlaceDetailsView: View {
    let place: Place

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Image(systemName: place.category.icon)
                    .font(.system(size: 60))
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 40)
                    .background(.thinMaterial)

                VStack(alignment: .leading, spacing: 16) {
                    Text(place.name)
                        .font(.largeTitle)
                        .fontWeight(.bold)

                    Label(
                        place.category.title,
                        systemImage: place.category.icon
                    )
                    .foregroundStyle(.secondary)

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
                }
                .padding()
            }
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack {
        PlaceDetailsView(
            place: PlaceService.places[0]
        )
    }
}
