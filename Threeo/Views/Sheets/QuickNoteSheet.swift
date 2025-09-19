import SwiftUI

struct QuickNoteSheet: View {
    let card: ThreeoCardSnapshot
    var onSubmit: (String) -> Void

    @Environment(\.dismiss) private var dismiss
    @State private var text: String = ""

    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text(card.title)) {
                    TextField("Add a quick note", text: $text, axis: .vertical)
                        .lineLimit(3...6)
                        .textInputAutocapitalization(.sentences)
                }
            }
            .navigationTitle("Quick Log")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") { dismiss() }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        guard !text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else { return }
                        onSubmit(text)
                        dismiss()
                    }
                    .disabled(text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
                }
            }
        }
    }
}

struct QuickNoteSheet_Previews: PreviewProvider {
    static var previews: some View {
        let store = ThreeoDataStore()
        if let card = store.activeCards.first {
            QuickNoteSheet(card: card) { _ in }
        }
    }
}
