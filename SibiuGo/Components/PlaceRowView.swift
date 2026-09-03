//
//  PlaceRowView.swift
//  SibiuGo
//
//  Created by Diana Ciodolan on 03/09/2026.
//

import SwiftUI

struct PlaceRowView: View {
    let place: Place

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

                HStack(spacing: 4) {
                    Image(systemName: "star.fill")

                    Text(
                        String(
                            format: "%.1f",
                            place.rating
                        )
                    )
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

#Preview {
    PlaceRowView(
        place: PlaceService.places[0]
    )
    .padding()
}
