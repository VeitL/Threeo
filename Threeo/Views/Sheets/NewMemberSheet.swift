import SwiftUI

struct NewMemberSheet: View {
    let category: ThreeoCategory
    var onComplete: (ThreeoMember) -> Void

    @Environment(\.dismiss) private var dismiss
    @State private var name: String = ""
    @State private var role: String = ""
    @State private var selectedSymbol: String
    @State private var selectedCards: Set<ThreeoCardType>

    init(category: ThreeoCategory, onComplete: @escaping (ThreeoMember) -> Void) {
        self.category = category
        self.onComplete = onComplete
        _selectedSymbol = State(initialValue: NewMemberSheet.defaultSymbol(for: category))
        _selectedCards = State(initialValue: Set(category.defaultCards))
    }

    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Profile")) {
                    TextField("Name", text: $name)
                    TextField(rolePlaceholder, text: $role)
                    symbolPicker
                }

                Section(header: Text("Cards"), footer: Text("Choose which cards to prepare for this member. You can adjust later.")) {
                    ForEach(category.defaultCards, id: \.self) { card in
                        Toggle(isOn: binding(for: card)) {
                            Label(card.title, systemImage: card.iconName)
                                .foregroundStyle(card.systemColor)
                        }
                    }
                }
            }
            .navigationTitle("New \(category.singularTitle)")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") { dismiss() }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Create") { createMember() }
                        .disabled(name.trimmingCharacters(in: .whitespaces).isEmpty)
                }
            }
        }
    }

    private var symbolPicker: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 12) {
                ForEach(NewMemberSheet.symbols(for: category), id: \.self) { symbol in
                    Button {
                        selectedSymbol = symbol
                    } label: {
                        Image(systemName: symbol)
                            .font(.title3)
                            .frame(width: 54, height: 54)
                            .background(
                                RoundedRectangle(cornerRadius: 16, style: .continuous)
                                    .fill(symbol == selectedSymbol ? category.accentColor.opacity(0.2) : Color(.systemGray6))
                            )
                            .overlay(
                                RoundedRectangle(cornerRadius: 16, style: .continuous)
                                    .stroke(symbol == selectedSymbol ? category.accentColor : Color.clear, lineWidth: 2)
                            )
                    }
                    .buttonStyle(.plain)
                }
            }
            .padding(.vertical, 4)
        }
    }

    private var rolePlaceholder: String {
        switch category {
        case .human:
            return "Role (e.g. Parent)"
        case .pet:
            return "Breed"
        case .plant:
            return "Location"
        }
    }

    private func binding(for card: ThreeoCardType) -> Binding<Bool> {
        Binding(
            get: { selectedCards.contains(card) },
            set: { isOn in
                if isOn {
                    selectedCards.insert(card)
                } else {
                    selectedCards.remove(card)
                }
            }
        )
    }

    private func createMember() {
        let trimmedName = name.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmedName.isEmpty else { return }
        let trimmedRole = role.trimmingCharacters(in: .whitespacesAndNewlines)
        let cards = selectedCards.sorted { $0.title < $1.title }.map { type in
            ThreeoSampleData.placeholderCard(for: type, memberName: trimmedName)
        }
        let member = ThreeoMember(
            category: category,
            displayName: trimmedName,
            roleDescription: trimmedRole.isEmpty ? defaultRole : trimmedRole,
            avatarSymbol: selectedSymbol,
            cards: cards
        )
        onComplete(member)
        dismiss()
    }

    private var defaultRole: String {
        switch category {
        case .human:
            return "Family"
        case .pet:
            return "Companion"
        case .plant:
            return "Plant"
        }
    }

    private static func symbols(for category: ThreeoCategory) -> [String] {
        switch category {
        case .human:
            return ["person.circle", "person.2.circle", "heart.circle", "figure.wave"]
        case .pet:
            return ["pawprint", "hare", "tortoise", "bird"]
        case .plant:
            return ["leaf", "tree", "sun.max", "drop"]
        }
    }

    private static func defaultSymbol(for category: ThreeoCategory) -> String {
        symbols(for: category).first ?? "person"
    }
}

struct NewMemberSheet_Previews: PreviewProvider {
    static var previews: some View {
        NewMemberSheet(category: .human) { _ in }
    }
}
