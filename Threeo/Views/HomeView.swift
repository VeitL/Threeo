import SwiftUI

struct HomeView: View {
    @EnvironmentObject private var store: ThreeoDataStore
    @State private var showFilters = false
    @State private var showNewMember = false
    @State private var presentedCardType: ThreeoCardType?
    @State private var quickNoteTarget: ThreeoCardType?

    private var categoryBinding: Binding<ThreeoCategory> {
        Binding(
            get: { store.selectedCategory },
            set: { store.select(category: $0) }
        )
    }

    private var dashboard: CategoryDashboard { store.selectedDashboard }

    var body: some View {
        NavigationStack {
            ZStack(alignment: .bottomTrailing) {
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(alignment: .leading, spacing: 24) {
                        CategoryHeroView(category: store.selectedCategory, memberCount: dashboard.members.count)

                        MemberCarouselView(
                            members: dashboard.members,
                            selectedMemberID: dashboard.selectedMember?.id,
                            onSelect: { store.selectMember($0) },
                            onAdd: { showNewMember = true }
                        )

                        if store.activeCards.isEmpty {
                            EmptyStateView(
                                title: "No cards yet",
                                message: "Turn cards on from the filter menu to start tracking",
                                actionTitle: "Choose Cards",
                                action: { showFilters = true }
                            )
                        } else {
                            AdaptiveCardGrid(cards: store.activeCards) { card in
                                DashboardCardView(
                                    card: card,
                                    onPrimaryAction: { quickNoteTarget = card.type },
                                    onRefresh: { store.refreshCard(card.type) }
                                )
                                .onTapGesture {
                                    presentedCardType = card.type
                                }
                            }
                        }
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 24)
                    .padding(.bottom, 120)
                }

                FloatingActionMenu(
                    category: store.selectedCategory,
                    onFilter: { showFilters = true },
                    onAdd: { showNewMember = true }
                )
                .padding(.trailing, 24)
                .padding(.bottom, 30)
            }
            .background(ThreeoTheme.neutralBackground.ignoresSafeArea())
            .navigationTitle("Threeo")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    CategoryPickerView(selectedCategory: categoryBinding)
                }

                ToolbarItem(placement: .navigationBarTrailing) {
                    ToolbarSubtitleView(member: dashboard.selectedMember)
                }
            }
        }
        .sheet(isPresented: $showFilters) {
            CardFilterSheet(
                category: store.selectedCategory,
                filters: store.availableFilters(for: store.selectedCategory),
                isCardEnabled: { store.isCardEnabled($0) },
                onToggle: { store.toggleCardVisibility($0) },
                onReset: { store.resetFilters(for: store.selectedCategory) },
                onEnableAll: { store.enableAllCards(for: store.selectedCategory) }
            )
            .presentationDetents([.medium, .large])
        }
        .sheet(isPresented: $showNewMember) {
            NewMemberSheet(category: store.selectedCategory) { member in
                store.addMember(member)
            }
            .presentationDetents([.fraction(0.5), .large])
        }
        .sheet(item: $presentedCardType) { cardType in
            if let snapshot = store.cardSnapshot(for: cardType) {
                CardDetailView(card: snapshot) { text in
                    store.addQuickNote(text, to: cardType)
                }
            }
        }
        .sheet(item: $quickNoteTarget) { cardType in
            if let snapshot = store.cardSnapshot(for: cardType) {
                QuickNoteSheet(card: snapshot) { text in
                    store.addQuickNote(text, to: cardType)
                }
            }
        }
    }
}

// MARK: - Previews

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(ThreeoDataStore())
    }
}
