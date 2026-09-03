import SwiftUI

struct PhotoCreditsView: View {
    var body: some View {
        List {
            Section("Locații") {
                creditRow(
                    place: "Piața Mare",
                    author: "Superchilum",
                    license: "CC BY 4.0"
                )

                creditRow(
                    place: "Podul Minciunilor",
                    author: "Wikimedia Commons contributor",
                    license: "CC BY-SA 4.0"
                )

                creditRow(
                    place: "Muzeul ASTRA",
                    author: "Wikimedia Commons contributor",
                    license: "CC BY-SA 3.0 RO"
                )

                creditRow(
                    place: "Parcul Sub Arini",
                    author: "Wikimedia Commons contributor",
                    license: "CC BY-SA 3.0"
                )
                
                creditRow(
                    place: "Catedrala Evanghelică",
                    author: "Superchilum",
                    license: "CC BY-SA 4.0"
                )

                creditRow(
                    place: "Palatul Brukenthal",
                    author: "Cezar Suceveanu",
                    license: "CC BY-SA 3.0 RO"
                )

                creditRow(
                    place: "Pasajul Scărilor",
                    author: "Cezar Suceveanu",
                    license: "CC BY-SA 3.0 RO"
                )

                creditRow(
                    place: "Catedrala Mitropolitană",
                    author: "Jose Mario Pires",
                    license: "CC BY-SA 4.0"
                )
                
                creditRow(
                    place: "Turnul Sfatului",
                    author: "Paul Colin Hennig",
                    license: "CC BY-SA 4.0"
                )
            }
        }
        .navigationTitle("Photo Credits")
        .navigationBarTitleDisplayMode(.inline)
    }

    private func creditRow(
        place: String,
        author: String,
        license: String
    ) -> some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(place)
                .font(.headline)

            Text(author)
                .foregroundStyle(.secondary)

            Text(license)
                .font(.caption)
                .foregroundStyle(.secondary)
        }
        .padding(.vertical, 4)
    }
}

#Preview {
    NavigationStack {
        PhotoCreditsView()
    }
}
