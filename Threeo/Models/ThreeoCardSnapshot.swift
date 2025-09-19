import SwiftUI

struct ThreeoCardSnapshot: Identifiable, Hashable {
    let type: ThreeoCardType
    var headline: String
    var highlightValue: String
    var metrics: [ThreeoMetric]
    var timeline: [ThreeoTimelineEvent]
    var footnote: String?
    var lastUpdated: Date
    var allowsQuickNote: Bool

    var id: ThreeoCardType { type }

    var category: ThreeoCategory { type.category }
    var iconName: String { type.iconName }
    var title: String { type.title }
    var caption: String { type.caption }
    var actionLabel: String { type.actionLabel }
    var accentColor: Color { type.systemColor }

    var relativeUpdateText: String {
        let formatter = RelativeDateTimeFormatter()
        formatter.unitsStyle = .full
        return formatter.localizedString(for: lastUpdated, relativeTo: Date())
    }
}
