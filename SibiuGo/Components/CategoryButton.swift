//
//  CategoryButton.swift
//  SibiuGo
//
//  Created by Diana Ciodolan on 03/09/2026.
//

import SwiftUI

struct CategoryButton: View {
    let category: PlaceCategory
    let isSelected: Bool

    var body: some View {
        VStack(spacing: 8) {
            Image(systemName: category.icon)
                .font(.title2)
                .frame(width: 52, height: 52)
                .background(
                    isSelected
                    ? Color.accentColor.opacity(0.2)
                    : Color.secondary.opacity(0.1)
                )
                .clipShape(Circle())

            Text(category.title)
                .font(.caption)
                .fontWeight(.medium)
        }
    }
}
