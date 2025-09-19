import SwiftUI

struct ThreeoMember: Identifiable, Hashable {
    let id: UUID
    var category: ThreeoCategory
    var displayName: String
    var roleDescription: String
    var avatarSymbol: String
    var cards: [ThreeoCardSnapshot]
    var notes: String?

    init(id: UUID = UUID(), category: ThreeoCategory, displayName: String, roleDescription: String, avatarSymbol: String, cards: [ThreeoCardSnapshot], notes: String? = nil) {
        self.id = id
        self.category = category
        self.displayName = displayName
        self.roleDescription = roleDescription
        self.avatarSymbol = avatarSymbol
        self.cards = cards
        self.notes = notes
    }
}

extension ThreeoMember {
    var initials: String {
        let names = displayName.split(separator: " ")
        let initials = names.compactMap { $0.first }
        return initials.isEmpty ? String(displayName.prefix(1)) : initials.map(String.init).joined()
    }

    var accentColor: Color { category.accentColor }
}
