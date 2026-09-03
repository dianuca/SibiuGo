//
//  Place.swift
//  SibiuGo
//
//  Created by Diana Ciodolan on 03/09/2026.
//

import Foundation

struct Place: Identifiable, Codable {
    let id: UUID
    let name: String
    let description: String
    let category: PlaceCategory
    let latitude: Double
    let longitude: Double
    let address: String
    let imageName: String
    let rating: Double
    let isFeatured: Bool
}
