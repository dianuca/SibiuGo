//
//  PlaceCategory.swift
//  SibiuGo
//
//  Created by Diana Ciodolan on 03/09/2026.
//

import Foundation

enum PlaceCategory: String, Codable, CaseIterable, Identifiable {
    case attraction
    case restaurant
    case cafe
    case museum
    case park
    case shopping
    case nightlife

    var id: String {
        rawValue
    }

    var title: String {
        switch self {
        case .attraction:
            return "Atracții"
        case .restaurant:
            return "Restaurante"
        case .cafe:
            return "Cafenele"
        case .museum:
            return "Muzee"
        case .park:
            return "Parcuri"
        case .shopping:
            return "Shopping"
        case .nightlife:
            return "Viață de noapte"
        }
    }

    var icon: String {
        switch self {
        case .attraction:
            return "building.columns"
        case .restaurant:
            return "fork.knife"
        case .cafe:
            return "cup.and.saucer"
        case .museum:
            return "building.columns.fill"
        case .park:
            return "leaf"
        case .shopping:
            return "bag"
        case .nightlife:
            return "moon.stars"
        }
    }
}
