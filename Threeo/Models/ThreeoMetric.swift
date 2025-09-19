import SwiftUI

struct ThreeoMetric: Identifiable, Hashable {
    let id = UUID()
    let label: String
    let value: String
    var caption: String?
    var trend: ThreeoTrend?
    var systemIcon: String?

    init(label: String, value: String, caption: String? = nil, trend: ThreeoTrend? = nil, systemIcon: String? = nil) {
        self.label = label
        self.value = value
        self.caption = caption
        self.trend = trend
        self.systemIcon = systemIcon
    }
}

enum ThreeoTrend: String, Hashable, Codable {
    case up
    case down
    case steady

    var iconName: String {
        switch self {
        case .up:
            return "arrow.up"
        case .down:
            return "arrow.down"
        case .steady:
            return "arrow.forward"
        }
    }

    var accessibilityDescription: String {
        switch self {
        case .up:
            return "Rising"
        case .down:
            return "Falling"
        case .steady:
            return "Stable"
        }
    }

    var tint: Color {
        switch self {
        case .up:
            return Color.green
        case .down:
            return Color.red
        case .steady:
            return Color.blue
        }
    }
}

struct ThreeoTimelineEvent: Identifiable, Hashable {
    let id = UUID()
    let title: String
    let subtitle: String
    let date: Date
    var iconName: String

    init(title: String, subtitle: String, date: Date, iconName: String = "calendar") {
        self.title = title
        self.subtitle = subtitle
        self.date = date
        self.iconName = iconName
    }
}
