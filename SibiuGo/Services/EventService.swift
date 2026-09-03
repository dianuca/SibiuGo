//
//  EventService.swift
//  SibiuGo
//
//  Created by Diana Ciodolan on 03/09/2026.
//

import Foundation

struct EventService {
    static let events: [Event] = [
        Event(
            id: "concert-piata-mare",
            title: "Concert în Piața Mare",
            description: "Concert în aer liber în centrul Sibiului.",
            venue: "Piața Mare",
            startDate: makeDate(
                year: 2026,
                month: 9,
                day: 12,
                hour: 20
            ),
            category: .music
        ),

        Event(
            id: "spectacol-radu-stanca",
            title: "Spectacol de teatru",
            description: "Spectacol la Teatrul Național Radu Stanca.",
            venue: "Teatrul Național Radu Stanca",
            startDate: makeDate(
                year: 2026,
                month: 9,
                day: 15,
                hour: 19
            ),
            category: .theatre
        ),

        Event(
            id: "festival-sibiu",
            title: "Festival în Sibiu",
            description: "Eveniment cultural desfășurat în centrul orașului.",
            venue: "Centrul Istoric",
            startDate: makeDate(
                year: 2026,
                month: 9,
                day: 20,
                hour: 17
            ),
            category: .festival
        )
    ]

    private static func makeDate(
        year: Int,
        month: Int,
        day: Int,
        hour: Int
    ) -> Date {
        Calendar.current.date(
            from: DateComponents(
                year: year,
                month: month,
                day: day,
                hour: hour
            )
        )!
    }
}
