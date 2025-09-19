import SwiftUI

enum ThreeoTheme {
    static let cornerRadius: CGFloat = 22
    static let cardPadding: CGFloat = 16
    static let gridSpacing: CGFloat = 16

    static func background(for category: ThreeoCategory) -> LinearGradient {
        let colors: [Color]
        switch category {
        case .human:
            colors = [Color("HumanAccent"), Color("HumanAccent").opacity(0.65)]
        case .pet:
            colors = [Color("PetAccent"), Color("PetAccent").opacity(0.65)]
        case .plant:
            colors = [Color("PlantAccent"), Color("PlantAccent").opacity(0.65)]
        }
        return LinearGradient(colors: colors, startPoint: .topLeading, endPoint: .bottomTrailing)
    }

    static var neutralBackground: Color { Color("NeutralBackground") }
}

extension View {
    func threeoCardStyle(for category: ThreeoCategory, elevated: Bool = true) -> some View {
        self
            .background(
                RoundedRectangle(cornerRadius: ThreeoTheme.cornerRadius, style: .continuous)
                    .fill(ThreeoTheme.background(for: category))
            )
            .overlay(
                RoundedRectangle(cornerRadius: ThreeoTheme.cornerRadius, style: .continuous)
                    .fill(Color.white.opacity(elevated ? 0.08 : 0.12))
                    .blendMode(.softLight)
            )
            .shadow(color: Color.black.opacity(elevated ? 0.15 : 0.08), radius: elevated ? 16 : 8, x: 0, y: elevated ? 12 : 6)
    }
}
