import SwiftUI

struct PlaceImageView: View {
    let place: Place
    var width: CGFloat? = nil
    let height: CGFloat
    var cornerRadius: CGFloat = 14

    var body: some View {
        Group {
            if let imageName = place.imageName,
               !imageName.isEmpty {

                Image(imageName)
                    .resizable()
                    .scaledToFill()

            } else {
                ZStack {
                    Rectangle()
                        .fill(.thinMaterial)

                    Image(systemName: place.category.icon)
                        .font(.system(size: 36))
                        .foregroundStyle(.secondary)
                }
            }
        }
        .frame(width: width, height: height)
        .frame(
            maxWidth: width == nil
                ? .infinity
                : nil
        )
        .clipped()
        .clipShape(
            RoundedRectangle(
                cornerRadius: cornerRadius
            )
        )
    }
}
