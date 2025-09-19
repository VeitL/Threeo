import SwiftUI

struct ToolbarSubtitleView: View {
    let member: ThreeoMember?

    var body: some View {
        if let member {
            HStack(spacing: 8) {
                Circle()
                    .fill(member.accentColor.opacity(0.25))
                    .overlay(
                        Image(systemName: member.avatarSymbol)
                            .font(.caption)
                            .foregroundStyle(member.accentColor)
                    )
                    .frame(width: 30, height: 30)
                VStack(alignment: .leading, spacing: 2) {
                    Text(member.displayName)
                        .font(.subheadline.weight(.semibold))
                    Text(member.roleDescription)
                        .font(.caption2)
                        .foregroundStyle(.secondary)
                }
            }
            .padding(.horizontal, 10)
            .padding(.vertical, 6)
            .background(.ultraThinMaterial, in: Capsule())
        }
    }
}

struct ToolbarSubtitleView_Previews: PreviewProvider {
    static var previews: some View {
        let store = ThreeoDataStore()
        ToolbarSubtitleView(member: store.selectedDashboard.selectedMember)
            .padding()
            .previewLayout(.sizeThatFits)
    }
}
