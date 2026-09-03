import Foundation

enum PlaceStatus: String, Codable {
    case open
    case temporarilyClosed

    var title: String {
        switch self {
        case .open:
            return "Deschis"
        case .temporarilyClosed:
            return "Temporar închis"
        }
    }

    var icon: String {
        switch self {
        case .open:
            return "checkmark.circle.fill"
        case .temporarilyClosed:
            return "exclamationmark.triangle.fill"
        }
    }
}
