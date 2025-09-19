import SwiftUI

enum ThreeoCategory: String, CaseIterable, Identifiable, Codable {
    case human = "human"
    case pet = "pet"
    case plant = "plant"

    var id: String { rawValue }

    var title: String {
        switch self {
        case .human:
            return "People"
        case .pet:
            return "Pets"
        case .plant:
            return "Plants"
        }
    }

    var singularTitle: String {
        switch self {
        case .human:
            return "Person"
        case .pet:
            return "Pet"
        case .plant:
            return "Plant"
        }
    }

    var iconName: String {
        switch self {
        case .human:
            return "person.3.sequence.fill"
        case .pet:
            return "pawprint.fill"
        case .plant:
            return "leaf.fill"
        }
    }

    var accentColor: Color {
        switch self {
        case .human:
            return Color("HumanAccent")
        case .pet:
            return Color("PetAccent")
        case .plant:
            return Color("PlantAccent")
        }
    }

    var tagline: String {
        switch self {
        case .human:
            return "Support your family with gentle, data-informed care."
        case .pet:
            return "Track wag-worthy wellness and stay ahead of every milestone."
        case .plant:
            return "Nurture leafy companions with mindful rituals and insights."
        }
    }

    var welcomeBlurb: String {
        switch self {
        case .human:
            return "Sync health metrics, log moods, and manage care plans for every loved one."
        case .pet:
            return "Weights, vaccines, and vet visits stay organized so you can focus on cuddles."
        case .plant:
            return "Watering, feeding, and growth snapshots keep your indoor jungle thriving."
        }
    }

    var defaultCards: [ThreeoCardType] {
        switch self {
        case .human:
            return [.healthSummary, .mood, .medication, .allergy, .thyroid]
        case .pet:
            return [.petWeight, .petVaccination, .petActivity]
        case .plant:
            return [.plantWatering, .plantFertilizing, .plantGrowth]
        }
    }
}
