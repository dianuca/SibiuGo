//
//  HomeView.swift
//  SibiuGo
//
//  Created by Diana Ciodolan on 03/09/2026.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        NavigationStack {
            VStack {
                Text("Descoperă Sibiul")
                    .font(.largeTitle)
                    .fontWeight(.bold)

                Text("Locuri, evenimente și experiențe.")
                    .foregroundStyle(.secondary)
            }
            .navigationTitle("SibiuGo")
        }
    }
}

#Preview {
    HomeView()
}
