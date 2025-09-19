import SwiftUI

enum ThreeoCardType: String, CaseIterable, Identifiable, Codable {
    case healthSummary
    case mood
    case medication
    case allergy
    case thyroid
    case petWeight
    case petVaccination
    case petActivity
    case plantWatering
    case plantFertilizing
    case plantGrowth

    var id: String { rawValue }

    var category: ThreeoCategory {
        switch self {
        case .healthSummary, .mood, .medication, .allergy, .thyroid:
            return .human
        case .petWeight, .petVaccination, .petActivity:
            return .pet
        case .plantWatering, .plantFertilizing, .plantGrowth:
            return .plant
        }
    }

    var title: String {
        switch self {
        case .healthSummary:
            return "Health Dashboard"
        case .mood:
            return "Mood Journal"
        case .medication:
            return "Medication"
        case .allergy:
            return "Allergy Watch"
        case .thyroid:
            return "Thyroid Log"
        case .petWeight:
            return "Weight Tracker"
        case .petVaccination:
            return "Vaccinations"
        case .petActivity:
            return "Activity"
        case .plantWatering:
            return "Watering"
        case .plantFertilizing:
            return "Fertilizing"
        case .plantGrowth:
            return "Growth Notes"
        }
    }

    var caption: String {
        switch self {
        case .healthSummary:
            return "See highlights from HealthKit and manual logs."
        case .mood:
            return "Capture the feeling of the day in a tap."
        case .medication:
            return "Keep dosage schedules and reminders tidy."
        case .allergy:
            return "Log triggers and symptoms as they appear."
        case .thyroid:
            return "Monitor key symptoms and lab reminders."
        case .petWeight:
            return "Spot trends and catch changes early."
        case .petVaccination:
            return "Upcoming shots and vet visits at a glance."
        case .petActivity:
            return "Celebrate daily walks and play sessions."
        case .plantWatering:
            return "Track watering rituals with seasonal context."
        case .plantFertilizing:
            return "Plan the next nutrient boost with ease."
        case .plantGrowth:
            return "Document new leaves, blooms, and height."
        }
    }

    var iconName: String {
        switch self {
        case .healthSummary:
            return "heart.circle.fill"
        case .mood:
            return "face.smiling.fill"
        case .medication:
            return "pills.fill"
        case .allergy:
            return "wind.circle.fill"
        case .thyroid:
            return "bolt.heart.fill"
        case .petWeight:
            return "scalemass.fill"
        case .petVaccination:
            return "syringe.fill"
        case .petActivity:
            return "figure.walk.circle.fill"
        case .plantWatering:
            return "drop.circle.fill"
        case .plantFertilizing:
            return "leaf.circle.fill"
        case .plantGrowth:
            return "chart.bar.xaxis"
        }
    }

    var actionLabel: String {
        switch self {
        case .healthSummary:
            return "Sync Now"
        case .mood:
            return "Log Mood"
        case .medication:
            return "Add Dose"
        case .allergy:
            return "Record Symptom"
        case .thyroid:
            return "Add Entry"
        case .petWeight:
            return "Record Weight"
        case .petVaccination:
            return "Schedule Vet"
        case .petActivity:
            return "Log Play"
        case .plantWatering:
            return "Log Watering"
        case .plantFertilizing:
            return "Plan Feeding"
        case .plantGrowth:
            return "Add Photo"
        }
    }

    var systemColor: Color { category.accentColor }
}
