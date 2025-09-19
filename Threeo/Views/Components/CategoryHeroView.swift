import SwiftUI

struct CategoryHeroView: View {
    let category: ThreeoCategory
    let memberCount: Int

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Label {
                Text(category.title)
                    .font(.title2.weight(.semibold))
                Text(category.tagline)
                    .font(.callout)
                    .foregroundStyle(.secondary)
            } icon: {
                Image(systemName: category.iconName)
                    .font(.title2)
                    .padding(12)
                    .background(.regularMaterial, in: RoundedRectangle(cornerRadius: 16, style: .continuous))
                    .foregroundStyle(category.accentColor)
            }

            HStack(spacing: 12) {
                StatPillView(icon: "person.crop.circle", title: "Members", value: "\(memberCount)")
                StatPillView(icon: "square.grid.2x2", title: "Cards", value: "\(category.defaultCards.count)")
            }
            .transition(.opacity.combined(with: .move(edge: .top)))
        }
        .padding(20)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(
            RoundedRectangle(cornerRadius: 28, style: .continuous)
                .fill(ThreeoTheme.background(for: category))
        )
        .overlay(
            RoundedRectangle(cornerRadius: 28, style: .continuous)
                .strokeBorder(.white.opacity(0.12))
        )
        .shadow(color: category.accentColor.opacity(0.25), radius: 20, x: 0, y: 12)
        .accessibilityElement(children: .combine)
    }
}

private struct StatPillView: View {
    let icon: String
    let title: String
    let value: String

    var body: some View {
        HStack(spacing: 8) {
            Image(systemName: icon)
                .font(.subheadline.weight(.semibold))
            VStack(alignment: .leading, spacing: 2) {
                Text(title.uppercased())
                    .font(.caption2)
                    .foregroundStyle(.secondary)
                Text(value)
                    .font(.headline)
            }
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 10)
        .background(
            RoundedRectangle(cornerRadius: 18, style: .continuous)
                .fill(.ultraThinMaterial)
        )
    }
}

struct CategoryHeroView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryHeroView(category: .human, memberCount: 2)
            .padding()
            .background(Color(.systemGroupedBackground))
    }
}
