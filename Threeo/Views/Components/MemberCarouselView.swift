import SwiftUI

struct MemberCarouselView: View {
    let members: [ThreeoMember]
    let selectedMemberID: ThreeoMember.ID?
    var onSelect: (ThreeoMember) -> Void
    var onAdd: () -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Text("Members")
                    .font(.headline)
                Spacer()
                Button("Manage") { onAdd() }
                    .font(.footnote.weight(.semibold))
            }

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 16) {
                    ForEach(members) { member in
                        Button {
                            onSelect(member)
                        } label: {
                            MemberBadgeView(member: member, isSelected: member.id == selectedMemberID)
                        }
                        .buttonStyle(.plain)
                        .accessibilityLabel("Select \(member.displayName)")
                    }

                    Button(action: onAdd) {
                        VStack(spacing: 8) {
                            Image(systemName: "plus")
                                .font(.title3.weight(.semibold))
                                .foregroundStyle(.secondary)
                                .frame(width: 56, height: 56)
                                .background(
                                    Circle()
                                        .strokeBorder(style: StrokeStyle(lineWidth: 1.2, dash: [4]))
                                        .foregroundStyle(.secondary.opacity(0.4))
                                )
                            Text("Add")
                                .font(.footnote)
                                .foregroundStyle(.secondary)
                        }
                        .padding(4)
                    }
                    .buttonStyle(.plain)
                    .accessibilityLabel("Add new member")
                }
                .padding(.vertical, 4)
            }
        }
    }
}

private struct MemberBadgeView: View {
    let member: ThreeoMember
    let isSelected: Bool

    var body: some View {
        VStack(spacing: 8) {
            ZStack {
                Circle()
                    .fill(isSelected ? member.accentColor.opacity(0.2) : Color(.systemBackground))
                    .overlay(
                        Circle()
                            .strokeBorder(isSelected ? member.accentColor : Color(.systemGray4), lineWidth: isSelected ? 3 : 1)
                    )
                    .frame(width: 66, height: 66)

                Image(systemName: member.avatarSymbol)
                    .font(.title2)
                    .foregroundStyle(isSelected ? member.accentColor : .primary)
            }

            VStack(spacing: 2) {
                Text(member.displayName)
                    .font(.footnote.weight(.semibold))
                    .foregroundStyle(isSelected ? .primary : .secondary)
                    .lineLimit(1)
                Text(member.roleDescription)
                    .font(.caption2)
                    .foregroundStyle(.secondary)
                    .lineLimit(1)
            }
        }
        .padding(.horizontal, 4)
        .padding(.vertical, 6)
        .background(
            RoundedRectangle(cornerRadius: 16, style: .continuous)
                .fill(isSelected ? member.accentColor.opacity(0.08) : Color.clear)
        )
        .animation(.spring(response: 0.4, dampingFraction: 0.9), value: isSelected)
    }
}

struct MemberCarouselView_Previews: PreviewProvider {
    static var previews: some View {
        let store = ThreeoDataStore()
        MemberCarouselView(
            members: store.selectedDashboard.members,
            selectedMemberID: store.selectedDashboard.selectedMember?.id,
            onSelect: { _ in },
            onAdd: {}
        )
        .padding()
        .background(Color(.systemGroupedBackground))
    }
}
