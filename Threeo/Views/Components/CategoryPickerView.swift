import SwiftUI

struct CategoryPickerView: View {
    @Binding var selectedCategory: ThreeoCategory

    var body: some View {
        Picker("Category", selection: $selectedCategory) {
            ForEach(ThreeoCategory.allCases) { category in
                Label(category.title, systemImage: category.iconName)
                    .tag(category)
            }
        }
        .pickerStyle(.menu)
        .tint(selectedCategory.accentColor)
        .accessibilityLabel("Select dashboard category")
    }
}

struct CategoryPickerView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryPickerView(selectedCategory: .constant(.human))
            .padding()
    }
}
