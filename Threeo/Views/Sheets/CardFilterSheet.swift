import SwiftUI

struct CardFilterSheet: View {
    let category: ThreeoCategory
    let filters: [ThreeoCardType]
    var isCardEnabled: (ThreeoCardType) -> Bool
    var onToggle: (ThreeoCardType) -> Void
    var onReset: () -> Void
    var onEnableAll: () -> Void

    var body: some View {
        NavigationStack {
            List {
                Section {
                    ForEach(filters) { card in
                        Toggle(isOn: binding(for: card)) {
                            Label(card.title, systemImage: card.iconName)
                                .foregroundStyle(card.systemColor)
                        }
                        .tint(card.systemColor)
                    }
                } footer: {
                    Text("Choose which cards appear on the \(category.title.lowercased()) dashboard. Changes apply instantly.")
                }
            }
            .listStyle(.insetGrouped)
            .navigationTitle("Cards for \(category.title)")
            .toolbar {
                ToolbarItemGroup(placement: .bottomBar) {
                    Button("Show All", action: onEnableAll)
                    Spacer()
                    Button("Reset") { onReset() }
                }
            }
        }
    }

    private func binding(for card: ThreeoCardType) -> Binding<Bool> {
        Binding(
            get: { isCardEnabled(card) },
            set: { newValue in
                let current = isCardEnabled(card)
                if current != newValue {
                    onToggle(card)
                }
            }
        )
    }
}

struct CardFilterSheet_Previews: PreviewProvider {
    static var previews: some View {
        CardFilterSheet(
            category: .human,
            filters: ThreeoCategory.human.defaultCards,
            isCardEnabled: { _ in true },
            onToggle: { _ in },
            onReset: {},
            onEnableAll: {}
        )
    }
}
