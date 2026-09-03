//
//  EventRowView.swift
//  SibiuGo
//
//  Created by Diana Ciodolan on 03/09/2026.
//

import SwiftUI

struct EventRowView: View {
    let event: Event

    var body: some View {
        HStack(spacing: 16) {
            Image(systemName: event.category.icon)
                .font(.title2)
                .frame(width: 55, height: 55)
                .background(.thinMaterial)
                .clipShape(
                    RoundedRectangle(cornerRadius: 14)
                )

            VStack(alignment: .leading, spacing: 5) {
                Text(event.title)
                    .font(.headline)

                Text(event.venue)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)

                Text(
                    event.startDate.formatted(
                        date: .abbreviated,
                        time: .shortened
                    )
                )
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
    EventRowView(
        event: EventService.events[0]
    )
    .padding()
}
