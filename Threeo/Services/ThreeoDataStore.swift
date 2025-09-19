import Foundation
import SwiftUI

final class ThreeoDataStore: ObservableObject {
    @Published private(set) var dashboards: [ThreeoCategory: CategoryDashboard]
    @Published var selectedCategory: ThreeoCategory {
        didSet {
            persistSelectedCategory()
        }
    }

    private static let selectedCategoryKey = "threeo.selectedCategory"

    init(dashboards: [ThreeoCategory: CategoryDashboard] = ThreeoSampleData.seedDashboards()) {
        self.dashboards = dashboards
        if let storedValue = UserDefaults.standard.string(forKey: Self.selectedCategoryKey),
           let storedCategory = ThreeoCategory(rawValue: storedValue),
           dashboards.keys.contains(storedCategory) {
            self.selectedCategory = storedCategory
        } else {
            self.selectedCategory = dashboards.keys.sorted(by: { $0.title < $1.title }).first ?? .human
        }
    }

    var selectedDashboard: CategoryDashboard {
        dashboards[selectedCategory] ?? CategoryDashboard(category: selectedCategory, members: [], selectedMemberID: nil, enabledCardTypes: Set(selectedCategory.defaultCards))
    }

    var selectedMember: ThreeoMember? {
        selectedDashboard.selectedMember
    }

    var activeCards: [ThreeoCardSnapshot] {
        guard let member = selectedMember else { return [] }
        let enabledTypes = selectedDashboard.enabledCardTypes
        return member.cards.filter { enabledTypes.contains($0.type) }
    }

    func select(category: ThreeoCategory) {
        guard selectedCategory != category else { return }
        withAnimation(.spring(response: 0.5, dampingFraction: 0.9)) {
            selectedCategory = category
        }
    }

    func selectMember(_ member: ThreeoMember) {
        updateDashboard(for: member.category) { dashboard in
            dashboard.selectedMemberID = member.id
        }
    }

    func toggleCardVisibility(_ cardType: ThreeoCardType) {
        updateDashboard(for: cardType.category) { dashboard in
            if dashboard.enabledCardTypes.contains(cardType) {
                dashboard.enabledCardTypes.remove(cardType)
            } else {
                dashboard.enabledCardTypes.insert(cardType)
            }
        }
    }

    func isCardEnabled(_ cardType: ThreeoCardType) -> Bool {
        dashboards[cardType.category]?.enabledCardTypes.contains(cardType) ?? false
    }

    func addMember(_ member: ThreeoMember) {
        updateDashboard(for: member.category) { dashboard in
            dashboard.members.append(member)
            dashboard.selectedMemberID = member.id
            let availableCards = Set(member.cards.map(\.type))
            dashboard.enabledCardTypes.formUnion(availableCards)
        }
    }

    func availableFilters(for category: ThreeoCategory) -> [ThreeoCardType] {
        let dashboard = dashboards[category]
        let cards = dashboard?.members.flatMap { $0.cards.map(\.type) } ?? category.defaultCards
        return Array(Set(cards)).sorted { $0.title < $1.title }
    }

    func cardSnapshot(for type: ThreeoCardType, in category: ThreeoCategory? = nil) -> ThreeoCardSnapshot? {
        let targetCategory = category ?? type.category
        guard let dashboard = dashboards[targetCategory],
              let member = dashboard.selectedMember else { return nil }
        return member.cards.first { $0.type == type }
    }

    func resetFilters(for category: ThreeoCategory) {
        updateDashboard(for: category) { dashboard in
            dashboard.enabledCardTypes = Set(category.defaultCards)
        }
    }

    func enableAllCards(for category: ThreeoCategory) {
        updateDashboard(for: category) { dashboard in
            let allTypes = dashboard.members.flatMap { $0.cards.map(\.type) }
            if allTypes.isEmpty {
                dashboard.enabledCardTypes = Set(category.defaultCards)
            } else {
                dashboard.enabledCardTypes = Set(allTypes)
            }
        }
    }

    func refreshCard(_ cardType: ThreeoCardType) {
        guard var dashboard = dashboards[cardType.category],
              let memberIndex = dashboard.members.firstIndex(where: { $0.id == dashboard.selectedMemberID }) else { return }

        var member = dashboard.members[memberIndex]
        if let cardIndex = member.cards.firstIndex(where: { $0.type == cardType }) {
            var card = member.cards[cardIndex]
            card.lastUpdated = Date()
            member.cards[cardIndex] = card
            dashboard.members[memberIndex] = member
            dashboards[cardType.category] = dashboard
        }
    }

    func addQuickNote(_ text: String, to cardType: ThreeoCardType) {
        guard var dashboard = dashboards[cardType.category],
              let memberIndex = dashboard.members.firstIndex(where: { $0.id == dashboard.selectedMemberID }) else { return }

        var member = dashboard.members[memberIndex]
        if let cardIndex = member.cards.firstIndex(where: { $0.type == cardType }) {
            var card = member.cards[cardIndex]
            card.timeline.insert(ThreeoTimelineEvent(title: "Quick note", subtitle: text, date: Date(), iconName: "sparkles"), at: 0)
            card.lastUpdated = Date()
            member.cards[cardIndex] = card
            dashboard.members[memberIndex] = member
            dashboards[cardType.category] = dashboard
        }
    }

    private func updateDashboard(for category: ThreeoCategory, transform: (inout CategoryDashboard) -> Void) {
        var dashboard = dashboards[category] ?? CategoryDashboard(category: category, members: [], selectedMemberID: nil, enabledCardTypes: Set(category.defaultCards))
        transform(&dashboard)
        dashboards[category] = dashboard
    }

    private func persistSelectedCategory() {
        UserDefaults.standard.set(selectedCategory.rawValue, forKey: Self.selectedCategoryKey)
    }
}

struct CategoryDashboard {
    var category: ThreeoCategory
    var members: [ThreeoMember]
    var selectedMemberID: ThreeoMember.ID?
    var enabledCardTypes: Set<ThreeoCardType>

    var selectedMember: ThreeoMember? {
        if let selectedMemberID,
           let found = members.first(where: { $0.id == selectedMemberID }) {
            return found
        }
        return members.first
    }
}
