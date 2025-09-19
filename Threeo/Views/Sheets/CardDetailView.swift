import SwiftUI

struct CardDetailView: View {
    let card: ThreeoCardSnapshot
    var onQuickAdd: (String) -> Void

    @Environment(\.dismiss) private var dismiss
    @State private var quickNote: String = ""
    @State private var workingCard: ThreeoCardSnapshot

    private var metricsGrid: [GridItem] {
        [GridItem(.adaptive(minimum: 140), spacing: 16)]
    }

    init(card: ThreeoCardSnapshot, onQuickAdd: @escaping (String) -> Void) {
        self.card = card
        self.onQuickAdd = onQuickAdd
        _workingCard = State(initialValue: card)
    }

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    header
                    metricGrid
                    timeline
                    if workingCard.allowsQuickNote {
                        quickNoteComposer
                    }
                }
                .padding(24)
            }
            .background(ThreeoTheme.neutralBackground.ignoresSafeArea())
            .navigationTitle(card.title)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Close") { dismiss() }
                }
            }
        }
    }

    private var header: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack(alignment: .center, spacing: 16) {
                Image(systemName: workingCard.iconName)
                    .font(.largeTitle)
                    .padding(18)
                    .background(workingCard.accentColor.opacity(0.15), in: RoundedRectangle(cornerRadius: 22, style: .continuous))
                VStack(alignment: .leading, spacing: 6) {
                    Text(workingCard.headline)
                        .font(.title2.weight(.semibold))
                    Text(workingCard.caption)
                        .font(.callout)
                        .foregroundStyle(.secondary)
                    Text("Last updated \(workingCard.relativeUpdateText)")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
            }
            Divider()
            Text(workingCard.footnote ?? "Stay consistent to keep insights flowing.")
                .font(.callout)
        }
    }

    private var metricGrid: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Metrics")
                .font(.headline)
            LazyVGrid(columns: metricsGrid, spacing: 16) {
                ForEach(workingCard.metrics) { metric in
                    VStack(alignment: .leading, spacing: 6) {
                        Text(metric.label)
                            .font(.subheadline.weight(.semibold))
                            .foregroundStyle(.secondary)
                        Text(metric.value)
                            .font(.title2.weight(.bold))
                        if let caption = metric.caption {
                            Text(caption)
                                .font(.footnote)
                                .foregroundStyle(.secondary)
                        }
                    }
                    .padding(16)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(
                        RoundedRectangle(cornerRadius: 20, style: .continuous)
                            .fill(Color.white)
                            .shadow(color: .black.opacity(0.05), radius: 8, x: 0, y: 4)
                    )
                }
            }
        }
    }

    private var timeline: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Timeline")
                .font(.headline)
            if workingCard.timeline.isEmpty {
                Text("No events yet. Start logging to see history.")
                    .font(.callout)
                    .foregroundStyle(.secondary)
            } else {
                ForEach(workingCard.timeline) { event in
                    HStack(alignment: .top, spacing: 12) {
                        Image(systemName: event.iconName)
                            .font(.headline)
                            .frame(width: 34, height: 34)
                            .background(workingCard.accentColor.opacity(0.15), in: RoundedRectangle(cornerRadius: 14, style: .continuous))
                        VStack(alignment: .leading, spacing: 4) {
                            Text(event.title)
                                .font(.subheadline.weight(.semibold))
                            Text(event.subtitle)
                                .font(.footnote)
                                .foregroundStyle(.secondary)
                            Text(event.date, style: .relative)
                                .font(.caption2)
                                .foregroundStyle(.secondary)
                        }
                        Spacer()
                    }
                    .padding(.vertical, 6)
                }
            }
        }
    }

    private var quickNoteComposer: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Quick note")
                .font(.headline)
            TextEditor(text: $quickNote)
                .frame(minHeight: 100)
                .padding(12)
                .background(
                    RoundedRectangle(cornerRadius: 18, style: .continuous)
                        .fill(Color.white)
                        .shadow(color: .black.opacity(0.04), radius: 6, x: 0, y: 3)
                )
            Button {
                let trimmed = quickNote.trimmingCharacters(in: .whitespacesAndNewlines)
                guard !trimmed.isEmpty else { return }
                onQuickAdd(trimmed)
                let event = ThreeoTimelineEvent(title: "Quick note", subtitle: trimmed, date: Date(), iconName: "sparkles")
                workingCard.timeline.insert(event, at: 0)
                workingCard = ThreeoCardSnapshot(
                    type: workingCard.type,
                    headline: workingCard.headline,
                    highlightValue: workingCard.highlightValue,
                    metrics: workingCard.metrics,
                    timeline: workingCard.timeline,
                    footnote: workingCard.footnote,
                    lastUpdated: Date(),
                    allowsQuickNote: workingCard.allowsQuickNote
                )
                quickNote = ""
            } label: {
                Text("Save Note")
                    .font(.headline)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 14)
                    .background(workingCard.accentColor, in: RoundedRectangle(cornerRadius: 16, style: .continuous))
                    .foregroundStyle(.white)
            }
        }
    }
}

struct CardDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let store = ThreeoDataStore()
        if let card = store.activeCards.first {
            CardDetailView(card: card) { _ in }
        }
    }
}
