//
//  EventCategory.swift
//  SibiuGo
//
//  Created by Diana Ciodolan on 03/09/2026.
//

import Foundation

enum EventCategory: String, Codable, CaseIterable, Identifiable {
    case music
    case theatre
    case festival
    case sport
    case other

    var id: String {
        rawValue
    }

    var title: String {
        switch self {
        case .music:
            return "Muzică"
        case .theatre:
            return "Teatru"
        case .festival:
            return "Festival"
        case .sport:
            return "Sport"
        case .other:
            return "Altele"
        }
    }

    var icon: String {
        switch self {
        case .music:
            return "music.note"
        case .theatre:
            return "theatermasks"
        case .festival:
            return "party.popper"
        case .sport:
            return "figure.run"
        case .other:
            return "calendar"
        }
    }
}
