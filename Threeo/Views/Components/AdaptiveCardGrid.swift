import SwiftUI

struct AdaptiveCardGrid<Content: View>: View {
    let cards: [ThreeoCardSnapshot]
    @ViewBuilder var content: (ThreeoCardSnapshot) -> Content

    private var columns: [GridItem] {
        [GridItem(.adaptive(minimum: 280), spacing: ThreeoTheme.gridSpacing, alignment: .top)]
    }

    var body: some View {
        LazyVGrid(columns: columns, spacing: ThreeoTheme.gridSpacing) {
            ForEach(cards) { card in
                content(card)
            }
        }
        .animation(.easeInOut(duration: 0.25), value: cards.map(\.id))
    }
}

struct AdaptiveCardGrid_Previews: PreviewProvider {
    static var previews: some View {
        let store = ThreeoDataStore()
        AdaptiveCardGrid(cards: store.activeCards) { card in
            DashboardCardView(card: card, onPrimaryAction: {}, onRefresh: {})
        }
        .padding()
    }
}
