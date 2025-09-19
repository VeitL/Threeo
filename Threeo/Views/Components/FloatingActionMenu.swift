import SwiftUI

struct FloatingActionMenu: View {
    let category: ThreeoCategory
    var onFilter: () -> Void
    var onAdd: () -> Void

    var body: some View {
        VStack(alignment: .trailing, spacing: 12) {
            Button(action: onAdd) {
                Label("New Member", systemImage: "person.badge.plus")
                    .font(.footnote.weight(.semibold))
                    .padding(.horizontal, 14)
                    .padding(.vertical, 10)
                    .background(.ultraThinMaterial, in: Capsule())
            }
            .buttonStyle(.plain)
            .tint(category.accentColor)

            Button(action: onFilter) {
                Label("Cards", systemImage: "slider.horizontal.3")
                    .font(.headline.weight(.semibold))
                    .padding(.horizontal, 22)
                    .padding(.vertical, 18)
                    .background(category.accentColor, in: Capsule(style: .circular))
                    .shadow(color: category.accentColor.opacity(0.4), radius: 12, x: 0, y: 8)
                    .foregroundStyle(.white)
            }
            .buttonStyle(.plain)
            .accessibilityLabel("Configure visible cards")
        }
    }
}

struct FloatingActionMenu_Previews: PreviewProvider {
    static var previews: some View {
        FloatingActionMenu(category: .human, onFilter: {}, onAdd: {})
            .padding()
            .background(Color(.systemGroupedBackground))
    }
}
