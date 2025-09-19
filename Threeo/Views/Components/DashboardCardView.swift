import SwiftUI

struct DashboardCardView: View {
    let card: ThreeoCardSnapshot
    var onPrimaryAction: () -> Void
    var onRefresh: () -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 18) {
            header
            highlight
            metrics
            timeline
            footer
        }
        .padding(20)
        .frame(maxWidth: .infinity, alignment: .leading)
        .threeoCardStyle(for: card.category)
        .foregroundStyle(.white)
        .overlay(alignment: .topTrailing) {
            Button(action: onRefresh) {
                Image(systemName: "arrow.clockwise")
                    .font(.subheadline.weight(.semibold))
                    .padding(10)
                    .background(.ultraThinMaterial, in: Circle())
            }
            .buttonStyle(.plain)
            .padding(16)
            .accessibilityLabel("Refresh \(card.title)")
        }
    }

    private var header: some View {
        HStack(alignment: .top) {
            Label {
                VStack(alignment: .leading, spacing: 4) {
                    Text(card.title)
                        .font(.headline)
                    Text(card.caption)
                        .font(.footnote)
                        .foregroundStyle(.white.opacity(0.85))
                }
            } icon: {
                ZStack {
                    RoundedRectangle(cornerRadius: 14, style: .continuous)
                        .fill(.white.opacity(0.15))
                        .frame(width: 48, height: 48)
                    Image(systemName: card.iconName)
                        .font(.title2)
                        .foregroundStyle(.white)
                }
            }
            Spacer()
        }
    }

    private var highlight: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(card.headline)
                .font(.callout.weight(.semibold))
                .foregroundStyle(.white.opacity(0.9))
            Text(card.highlightValue)
                .font(.system(size: 42, weight: .bold, design: .rounded))
                .foregroundStyle(.white)
        }
    }

    private var metrics: some View {
        VStack(spacing: 10) {
            ForEach(card.metrics) { metric in
                CardMetricRow(metric: metric)
                    .accessibilityElement(children: .combine)
            }
        }
    }

    private var timeline: some View {
        VStack(alignment: .leading, spacing: 8) {
            if !card.timeline.isEmpty {
                Divider().overlay(.white.opacity(0.2))
                Text("Recent activity")
                    .font(.caption.weight(.semibold))
                    .textCase(.uppercase)
                    .foregroundStyle(.white.opacity(0.6))
                ForEach(card.timeline.prefix(2)) { event in
                    TimelineRow(event: event)
                }
            }
        }
    }

    private var footer: some View {
        VStack(alignment: .leading, spacing: 10) {
            if let footnote = card.footnote {
                Text(footnote)
                    .font(.footnote)
                    .foregroundStyle(.white.opacity(0.85))
            }

            HStack {
                Text("Updated \(card.relativeUpdateText)")
                    .font(.caption)
                    .foregroundStyle(.white.opacity(0.7))
                Spacer()
                Button(action: onPrimaryAction) {
                    Text(card.actionLabel)
                        .font(.footnote.weight(.semibold))
                        .padding(.horizontal, 18)
                        .padding(.vertical, 10)
                        .background(
                            Capsule()
                                .fill(.white.opacity(0.18))
                        )
                }
                .buttonStyle(.plain)
                .accessibilityLabel("\(card.actionLabel) for \(card.title)")
            }
        }
    }
}

private struct CardMetricRow: View {
    let metric: ThreeoMetric

    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            if let icon = metric.systemIcon {
                Image(systemName: icon)
                    .font(.subheadline.weight(.medium))
                    .frame(width: 26, height: 26)
                    .background(.white.opacity(0.18), in: Circle())
            }
            VStack(alignment: .leading, spacing: 4) {
                Text(metric.label)
                    .font(.subheadline)
                Text(metric.value)
                    .font(.title3.weight(.semibold))
                if let caption = metric.caption {
                    HStack(spacing: 4) {
                        if let trend = metric.trend {
                            Image(systemName: trend.iconName)
                                .font(.caption2.weight(.semibold))
                                .foregroundStyle(trend.tint)
                                .accessibilityHidden(true)
                        }
                        Text(caption)
                            .font(.caption)
                            .foregroundStyle(.white.opacity(0.7))
                    }
                }
            }
            Spacer(minLength: 0)
        }
        .padding(.horizontal, 14)
        .padding(.vertical, 12)
        .background(.white.opacity(0.08), in: RoundedRectangle(cornerRadius: 18, style: .continuous))
    }
}

private struct TimelineRow: View {
    let event: ThreeoTimelineEvent

    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            Image(systemName: event.iconName)
                .font(.headline)
                .frame(width: 28, height: 28)
                .background(.white.opacity(0.14), in: RoundedRectangle(cornerRadius: 12, style: .continuous))
            VStack(alignment: .leading, spacing: 4) {
                Text(event.title)
                    .font(.subheadline.weight(.semibold))
                Text(event.subtitle)
                    .font(.caption)
                    .foregroundStyle(.white.opacity(0.8))
                Text(event.date, style: .relative)
                    .font(.caption2)
                    .foregroundStyle(.white.opacity(0.6))
            }
            Spacer()
        }
        .padding(.vertical, 6)
    }
}

struct DashboardCardView_Previews: PreviewProvider {
    static var previews: some View {
        let store = ThreeoDataStore()
        if let card = store.activeCards.first {
            DashboardCardView(card: card, onPrimaryAction: {}, onRefresh: {})
                .padding()
                .previewLayout(.sizeThatFits)
        }
    }
}
