//
//  EventDetailsView.swift
//  SibiuGo
//
//  Created by Diana Ciodolan on 03/09/2026.
//

import SwiftUI

struct EventDetailsView: View {
    let event: Event

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Image(systemName: event.category.icon)
                    .font(.system(size: 60))
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 40)
                    .background(.thinMaterial)

                VStack(alignment: .leading, spacing: 16) {
                    Text(event.title)
                        .font(.largeTitle)
                        .fontWeight(.bold)

                    Label(
                        event.category.title,
                        systemImage: event.category.icon
                    )
                    .foregroundStyle(.secondary)

                    Divider()

                    Label(
                        event.startDate.formatted(
                            date: .long,
                            time: .shortened
                        ),
                        systemImage: "calendar"
                    )

                    Label(
                        event.venue,
                        systemImage: "mappin.and.ellipse"
                    )

                    Divider()

                    Text("Despre eveniment")
                        .font(.title2)
                        .fontWeight(.semibold)

                    Text(event.description)
                }
                .padding()
            }
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack {
        EventDetailsView(
            event: EventService.events[0]
        )
    }
}
