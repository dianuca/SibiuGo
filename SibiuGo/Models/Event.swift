//
//  Event.swift
//  SibiuGo
//
//  Created by Diana Ciodolan on 03/09/2026.
//

import Foundation

struct Event: Identifiable, Codable {
    let id: String
    let title: String
    let description: String
    let venue: String
    let startDate: Date
    let category: EventCategory
}
