import SwiftUI

struct EventsView: View {
    private let events = EventService.events

    private var sortedEvents: [Event] {
        events.sorted {
            $0.startDate < $1.startDate
        }
    }

    var body: some View {
        NavigationStack {
            List(sortedEvents) { event in
                EventRowView(event: event)
            }
            .listStyle(.plain)
            .navigationTitle("Evenimente")
        }
    }
}

#Preview {
    EventsView()
}
