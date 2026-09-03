//
//  PlaceService.swift
//  SibiuGo
//
//  Created by Diana Ciodolan on 03/09/2026.
//

import Foundation

struct PlaceService {
    static let places: [Place] = [
        Place(
            id: UUID(),
            name: "Piața Mare",
            description: "Piața centrală a Sibiului și unul dintre cele mai cunoscute locuri din oraș.",
            category: .attraction,
            latitude: 45.7966,
            longitude: 24.1517,
            address: "Piața Mare, Sibiu",
            imageName: "piata-mare",
            rating: 4.8,
            isFeatured: true
        ),

        Place(
            id: UUID(),
            name: "Podul Minciunilor",
            description: "Unul dintre simbolurile Sibiului, situat între Piața Mică și Piața Huet.",
            category: .attraction,
            latitude: 45.7981,
            longitude: 24.1505,
            address: "Piața Mică, Sibiu",
            imageName: "podul-minciunilor",
            rating: 4.7,
            isFeatured: true
        ),

        Place(
            id: UUID(),
            name: "Muzeul ASTRA",
            description: "Muzeu în aer liber dedicat civilizației tradiționale din România.",
            category: .museum,
            latitude: 45.7556,
            longitude: 24.1168,
            address: "Strada Pădurea Dumbrava 16-20, Sibiu",
            imageName: "muzeul-astra",
            rating: 4.9,
            isFeatured: true
        ),

        Place(
            id: UUID(),
            name: "Parcul Sub Arini",
            description: "Unul dintre cele mai cunoscute parcuri din Sibiu.",
            category: .park,
            latitude: 45.7812,
            longitude: 24.1377,
            address: "Bulevardul Victoriei, Sibiu",
            imageName: "sub-arini",
            rating: 4.7,
            isFeatured: false
        )
    ]
}
