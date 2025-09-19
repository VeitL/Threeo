import Foundation

enum ThreeoSampleData {
    static func seedDashboards() -> [ThreeoCategory: CategoryDashboard] {
        let humanMembers = humanSamples()
        let petMembers = petSamples()
        let plantMembers = plantSamples()

        return [
            .human: CategoryDashboard(
                category: .human,
                members: humanMembers,
                selectedMemberID: humanMembers.first?.id,
                enabledCardTypes: Set(ThreeoCategory.human.defaultCards)
            ),
            .pet: CategoryDashboard(
                category: .pet,
                members: petMembers,
                selectedMemberID: petMembers.first?.id,
                enabledCardTypes: Set(ThreeoCategory.pet.defaultCards)
            ),
            .plant: CategoryDashboard(
                category: .plant,
                members: plantMembers,
                selectedMemberID: plantMembers.first?.id,
                enabledCardTypes: Set(ThreeoCategory.plant.defaultCards)
            )
        ]
    }

    private static func humanSamples() -> [ThreeoMember] {
        let maya = ThreeoMember(
            category: .human,
            displayName: "Maya Chen",
            roleDescription: "Mom",
            avatarSymbol: "person.crop.circle.badge.checkmark",
            cards: [
                healthSummaryCard(),
                moodCard(name: "Maya"),
                medicationCard(),
                allergyCard(),
                thyroidCard()
            ],
            notes: "Prefers evening medication reminders"
        )

        let eli = ThreeoMember(
            category: .human,
            displayName: "Eli Chen",
            roleDescription: "Son",
            avatarSymbol: "person.crop.circle.badge.questionmark",
            cards: [
                healthSummaryCard(headline: "Ready to Explore", highlight: "92%"),
                moodCard(name: "Eli", emotion: "Curious", highlight: "Curious"),
                allergyCard(name: "Eli", trigger: "Peanut"),
                medicationCard(name: "Eli", regimen: "Vitamin D")
            ]
        )

        return [maya, eli]
    }

    private static func petSamples() -> [ThreeoMember] {
        let luna = ThreeoMember(
            category: .pet,
            displayName: "Luna",
            roleDescription: "Golden Retriever",
            avatarSymbol: "pawprint.circle",
            cards: [
                petWeightCard(),
                petVaccinationCard(),
                petActivityCard()
            ],
            notes: "Loves early morning runs"
        )

        let niko = ThreeoMember(
            category: .pet,
            displayName: "Niko",
            roleDescription: "Tabby Cat",
            avatarSymbol: "pawprint.fill",
            cards: [
                petWeightCard(name: "Niko", weight: "4.3 kg", change: "↗︎ 0.1 kg"),
                petActivityCard(name: "Niko", highlight: "Playful")
            ],
            notes: "Prefers feather wand toys"
        )

        return [luna, niko]
    }

    private static func plantSamples() -> [ThreeoMember] {
        let monstera = ThreeoMember(
            category: .plant,
            displayName: "Monstera Deliciosa",
            roleDescription: "Living Room",
            avatarSymbol: "leaf.circle",
            cards: [
                plantWateringCard(),
                plantFertilizingCard(),
                plantGrowthCard()
            ],
            notes: "Rotate weekly for even light"
        )

        let bonsai = ThreeoMember(
            category: .plant,
            displayName: "Juniper Bonsai",
            roleDescription: "Desk Companion",
            avatarSymbol: "tree.circle",
            cards: [
                plantWateringCard(name: "Bonsai", cadence: "Mist daily"),
                plantGrowthCard(name: "Bonsai", headline: "Shaping"),
                plantFertilizingCard(name: "Bonsai", product: "Bonsai feed", cadence: "Every 4 weeks")
            ]
        )

        return [monstera, bonsai]
    }
}

// MARK: - Human Cards

private extension ThreeoSampleData {
    static func healthSummaryCard(headline: String = "Steady Momentum", highlight: String = "82%") -> ThreeoCardSnapshot {
        ThreeoCardSnapshot(
            type: .healthSummary,
            headline: headline,
            highlightValue: highlight,
            metrics: [
                ThreeoMetric(label: "Steps", value: "8,420", caption: "Goal 9,500", trend: .up, systemIcon: "figure.walk"),
                ThreeoMetric(label: "Sleep", value: "7h 10m", caption: "Quality 91%", trend: .steady, systemIcon: "moon.zzz"),
                ThreeoMetric(label: "Resting HR", value: "62 bpm", caption: "↓ 3 vs last week", trend: .down, systemIcon: "heart.fill")
            ],
            timeline: [
                ThreeoTimelineEvent(title: "Morning Yoga", subtitle: "28 min mindful flow", date: hoursAgo(6), iconName: "figure.mind.and.body"),
                ThreeoTimelineEvent(title: "Sync Complete", subtitle: "HealthKit updated", date: minutesAgo(15), iconName: "arrow.triangle.2.circlepath")
            ],
            footnote: "HealthKit refreshed 15 minutes ago.",
            lastUpdated: minutesAgo(15),
            allowsQuickNote: false
        )
    }

    static func moodCard(name: String, emotion: String = "Balanced", highlight: String = "Balanced") -> ThreeoCardSnapshot {
        ThreeoCardSnapshot(
            type: .mood,
            headline: "Today's Mood",
            highlightValue: highlight,
            metrics: [
                ThreeoMetric(label: "Energy", value: "7/10", caption: "Bright mornings", trend: .up, systemIcon: "sun.max.fill"),
                ThreeoMetric(label: "Focus", value: "Calm", caption: "Mindful lunch break", trend: .steady, systemIcon: "brain.head.profile")
            ],
            timeline: [
                ThreeoTimelineEvent(title: "Journaled gratitude", subtitle: "3 highlights from today", date: hoursAgo(3), iconName: "pencil"),
                ThreeoTimelineEvent(title: "Shared mood check-in", subtitle: "with family", date: hoursAgo(21), iconName: "bubble.left")
            ],
            footnote: "\(name) feels \(emotion.lowercased()) today.",
            lastUpdated: minutesAgo(30),
            allowsQuickNote: true
        )
    }

    static func medicationCard(name: String = "Maya", regimen: String = "Levothyroxine") -> ThreeoCardSnapshot {
        ThreeoCardSnapshot(
            type: .medication,
            headline: "Daily Medications",
            highlightValue: "On track",
            metrics: [
                ThreeoMetric(label: regimen, value: "50 mcg", caption: "Taken at 7:15 AM", trend: .steady, systemIcon: "pills"),
                ThreeoMetric(label: "Supplements", value: "2 of 3", caption: "Vitamin D pending", trend: .down, systemIcon: "capsule.portrait")
            ],
            timeline: [
                ThreeoTimelineEvent(title: "Morning dose", subtitle: "Logged successfully", date: hoursAgo(4), iconName: "checkmark.circle"),
                ThreeoTimelineEvent(title: "Evening reminder", subtitle: "Set for 8:00 PM", date: hoursAhead(3), iconName: "alarm")
            ],
            footnote: "\(name)'s reminders adjust around meal times.",
            lastUpdated: hoursAgo(2),
            allowsQuickNote: true
        )
    }

    static func allergyCard(name: String = "Maya", trigger: String = "Pollen") -> ThreeoCardSnapshot {
        ThreeoCardSnapshot(
            type: .allergy,
            headline: "Allergy Watch",
            highlightValue: "Low",
            metrics: [
                ThreeoMetric(label: "Air Quality", value: "45 AQI", caption: "Clear sky today", trend: .down, systemIcon: "wind"),
                ThreeoMetric(label: "Symptoms", value: "Mild", caption: "Nasal drip", trend: .steady, systemIcon: "nose")
            ],
            timeline: [
                ThreeoTimelineEvent(title: "Antihistamine", subtitle: "Taken at breakfast", date: hoursAgo(6), iconName: "checkmark"),
                ThreeoTimelineEvent(title: "Pollen alert", subtitle: "Trees moderate", date: hoursAgo(22), iconName: "exclamationmark.triangle")
            ],
            footnote: "Primary trigger: \(trigger).",
            lastUpdated: hoursAgo(1),
            allowsQuickNote: true
        )
    }

    static func thyroidCard() -> ThreeoCardSnapshot {
        ThreeoCardSnapshot(
            type: .thyroid,
            headline: "Thyroid Wellness",
            highlightValue: "Steady",
            metrics: [
                ThreeoMetric(label: "Energy", value: "6/10", caption: "Improving", trend: .up, systemIcon: "bolt.heart"),
                ThreeoMetric(label: "Hair", value: "Normal", caption: "Less shedding", trend: .up, systemIcon: "comb.fill"),
                ThreeoMetric(label: "Digestion", value: "Balanced", caption: "Routine stable", trend: .steady, systemIcon: "leaf")
            ],
            timeline: [
                ThreeoTimelineEvent(title: "Lab work", subtitle: "TSH 1.7", date: daysAgo(14), iconName: "lab.flask"),
                ThreeoTimelineEvent(title: "Next check", subtitle: "Scheduled in 2 months", date: daysAhead(60), iconName: "calendar.badge.clock")
            ],
            footnote: "Tracked alongside medication adherence.",
            lastUpdated: daysAgo(2),
            allowsQuickNote: true
        )
    }
}

// MARK: - Pet Cards

private extension ThreeoSampleData {
    static func petWeightCard(name: String = "Luna", weight: String = "28.4 kg", change: String = "↘︎ 0.2 kg") -> ThreeoCardSnapshot {
        ThreeoCardSnapshot(
            type: .petWeight,
            headline: "Healthy Weight",
            highlightValue: weight,
            metrics: [
                ThreeoMetric(label: "Goal", value: "27.5-29.5 kg", caption: "Breed healthy range", trend: .steady, systemIcon: "scalemass"),
                ThreeoMetric(label: "Change", value: change, caption: "vs last month", trend: change.contains("↗") ? .up : .down, systemIcon: "arrow.up.and.down")
            ],
            timeline: [
                ThreeoTimelineEvent(title: "Weigh-in", subtitle: "At home smart bowl", date: daysAgo(6), iconName: "scalemass"),
                ThreeoTimelineEvent(title: "Vet visit", subtitle: "Annual wellness", date: daysAhead(22), iconName: "stethoscope")
            ],
            footnote: "Weight checks every Sunday.",
            lastUpdated: daysAgo(6),
            allowsQuickNote: true
        )
    }

    static func petVaccinationCard() -> ThreeoCardSnapshot {
        ThreeoCardSnapshot(
            type: .petVaccination,
            headline: "Vaccination Plan",
            highlightValue: "Next: Oct 12",
            metrics: [
                ThreeoMetric(label: "Rabies", value: "Due in 3 weeks", caption: "Reminder set", trend: .down, systemIcon: "bell"),
                ThreeoMetric(label: "Bordetella", value: "Up to date", caption: "Last month", trend: .steady, systemIcon: "shield.checkerboard")
            ],
            timeline: [
                ThreeoTimelineEvent(title: "Distemper booster", subtitle: "Completed", date: daysAgo(20), iconName: "checkmark.seal"),
                ThreeoTimelineEvent(title: "Rabies", subtitle: "Schedule with Dr. Lee", date: daysAhead(21), iconName: "calendar")
            ],
            footnote: "All records saved for easy vet sharing.",
            lastUpdated: daysAgo(1),
            allowsQuickNote: false
        )
    }

    static func petActivityCard(name: String = "Luna", highlight: String = "Joyful") -> ThreeoCardSnapshot {
        ThreeoCardSnapshot(
            type: .petActivity,
            headline: "Activity",
            highlightValue: highlight,
            metrics: [
                ThreeoMetric(label: "Walks", value: "2 of 2", caption: "73 active minutes", trend: .up, systemIcon: "figure.walk"),
                ThreeoMetric(label: "Play", value: "Fetch x4", caption: "15 min backyard", trend: .up, systemIcon: "tennisball")
            ],
            timeline: [
                ThreeoTimelineEvent(title: "Neighborhood run", subtitle: "3.2 km", date: hoursAgo(5), iconName: "location")
            ],
            footnote: "\(name) met her move goal.",
            lastUpdated: hoursAgo(2),
            allowsQuickNote: true
        )
    }
}

// MARK: - Plant Cards

private extension ThreeoSampleData {
    static func plantWateringCard(name: String = "Monstera", cadence: String = "Every 5 days") -> ThreeoCardSnapshot {
        ThreeoCardSnapshot(
            type: .plantWatering,
            headline: "Watering",
            highlightValue: "Moist",
            metrics: [
                ThreeoMetric(label: "Schedule", value: cadence, caption: "Next due in 2 days", trend: .steady, systemIcon: "drop"),
                ThreeoMetric(label: "Soil", value: "42% moisture", caption: "Sensor reading", trend: .down, systemIcon: "gauges")
            ],
            timeline: [
                ThreeoTimelineEvent(title: "Deep watering", subtitle: "800 ml", date: daysAgo(3), iconName: "drop.triangle"),
                ThreeoTimelineEvent(title: "Humidity boost", subtitle: "Misting session", date: hoursAgo(26), iconName: "cloud.drizzle")
            ],
            footnote: "Remember to drain saucer after watering.",
            lastUpdated: daysAgo(1),
            allowsQuickNote: true
        )
    }

    static func plantFertilizingCard(name: String = "Monstera", product: String = "Organic Grow", cadence: String = "Every 3 weeks") -> ThreeoCardSnapshot {
        ThreeoCardSnapshot(
            type: .plantFertilizing,
            headline: "Feeding",
            highlightValue: "Next in 5d",
            metrics: [
                ThreeoMetric(label: "Product", value: product, caption: cadence, trend: .steady, systemIcon: "leaf"),
                ThreeoMetric(label: "Last", value: format(date: daysAgo(16)), caption: "Diluted 1:3", trend: .up, systemIcon: "sprinkler.and.droplets")
            ],
            timeline: [
                ThreeoTimelineEvent(title: "Fertilized", subtitle: "Foliar spray", date: daysAgo(16), iconName: "drop.fill"),
                ThreeoTimelineEvent(title: "Next reminder", subtitle: "Push notification", date: daysAhead(5), iconName: "bell.badge")
            ],
            footnote: "Avoid feeding on very sunny days.",
            lastUpdated: daysAgo(16),
            allowsQuickNote: true
        )
    }

    static func plantGrowthCard(name: String = "Monstera", headline: String = "Unfurling") -> ThreeoCardSnapshot {
        ThreeoCardSnapshot(
            type: .plantGrowth,
            headline: headline,
            highlightValue: "New leaf",
            metrics: [
                ThreeoMetric(label: "Height", value: "122 cm", caption: "↑ 4 cm this month", trend: .up, systemIcon: "ruler"),
                ThreeoMetric(label: "Leaves", value: "14", caption: "3 new fenestrations", trend: .up, systemIcon: "leaf.arrow.circlepath")
            ],
            timeline: [
                ThreeoTimelineEvent(title: "Photo note", subtitle: "Added to gallery", date: daysAgo(1), iconName: "camera")
            ],
            footnote: "Bright, indirect light every morning.",
            lastUpdated: daysAgo(1),
            allowsQuickNote: true
        )
    }
}

// MARK: - Helpers

private extension ThreeoSampleData {
    static func minutesAgo(_ minutes: Int) -> Date {
        Date().addingTimeInterval(TimeInterval(-minutes * 60))
    }

    static func hoursAgo(_ hours: Int) -> Date {
        minutesAgo(hours * 60)
    }

    static func hoursAhead(_ hours: Int) -> Date {
        Date().addingTimeInterval(TimeInterval(hours * 60 * 60))
    }

    static func daysAgo(_ days: Int) -> Date {
        Date().addingTimeInterval(TimeInterval(-days * 24 * 60 * 60))
    }

    static func daysAhead(_ days: Int) -> Date {
        Date().addingTimeInterval(TimeInterval(days * 24 * 60 * 60))
    }

    static func format(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter.string(from: date)
    }

    static func placeholderCard(for type: ThreeoCardType, memberName: String) -> ThreeoCardSnapshot {
        switch type {
        case .healthSummary:
            return ThreeoCardSnapshot(
                type: .healthSummary,
                headline: "Welcome aboard",
                highlightValue: "--",
                metrics: [ThreeoMetric(label: "Steps", value: "--", caption: "Sync to begin", trend: .steady, systemIcon: "figure.walk")],
                timeline: [],
                footnote: "Connect HealthKit to populate data.",
                lastUpdated: Date(),
                allowsQuickNote: false
            )
        case .mood:
            return ThreeoCardSnapshot(
                type: .mood,
                headline: "Log the first mood",
                highlightValue: "--",
                metrics: [ThreeoMetric(label: "Energy", value: "--", caption: "Tap log mood", trend: .steady, systemIcon: "sparkles")],
                timeline: [],
                footnote: "Mood entries help spot patterns.",
                lastUpdated: Date(),
                allowsQuickNote: true
            )
        case .medication:
            return ThreeoCardSnapshot(
                type: .medication,
                headline: "Add routine",
                highlightValue: "No schedule",
                metrics: [ThreeoMetric(label: "Reminders", value: "Off", caption: "Tap to configure", trend: .steady, systemIcon: "alarm")],
                timeline: [],
                footnote: "Keep dosage details handy.",
                lastUpdated: Date(),
                allowsQuickNote: true
            )
        case .allergy:
            return ThreeoCardSnapshot(
                type: .allergy,
                headline: "Track symptoms",
                highlightValue: "None",
                metrics: [ThreeoMetric(label: "Triggers", value: "Unknown", caption: "Log first reaction", trend: .steady, systemIcon: "wind")],
                timeline: [],
                footnote: "Stay ready for seasonal shifts.",
                lastUpdated: Date(),
                allowsQuickNote: true
            )
        case .thyroid:
            return ThreeoCardSnapshot(
                type: .thyroid,
                headline: "Start your journal",
                highlightValue: "--",
                metrics: [ThreeoMetric(label: "Energy", value: "--", caption: "Daily reflections", trend: .steady, systemIcon: "bolt.heart")],
                timeline: [],
                footnote: "Combine with medication tracking.",
                lastUpdated: Date(),
                allowsQuickNote: true
            )
        case .petWeight:
            return ThreeoCardSnapshot(
                type: .petWeight,
                headline: "First weigh-in",
                highlightValue: "--",
                metrics: [ThreeoMetric(label: "Target", value: "Set goal", caption: "Ideal range", trend: .steady, systemIcon: "scalemass")],
                timeline: [],
                footnote: "Weigh on a consistent schedule.",
                lastUpdated: Date(),
                allowsQuickNote: true
            )
        case .petVaccination:
            return ThreeoCardSnapshot(
                type: .petVaccination,
                headline: "Add vet records",
                highlightValue: "No upcoming",
                metrics: [ThreeoMetric(label: "Vaccines", value: "--", caption: "Log due dates", trend: .steady, systemIcon: "syringe")],
                timeline: [],
                footnote: "Keep the schedule in sync with your vet.",
                lastUpdated: Date(),
                allowsQuickNote: false
            )
        case .petActivity:
            return ThreeoCardSnapshot(
                type: .petActivity,
                headline: "Track playtime",
                highlightValue: "--",
                metrics: [ThreeoMetric(label: "Walks", value: "--", caption: "Add first walk", trend: .steady, systemIcon: "figure.walk")],
                timeline: [],
                footnote: "Celebrate daily movement.",
                lastUpdated: Date(),
                allowsQuickNote: true
            )
        case .plantWatering:
            return ThreeoCardSnapshot(
                type: .plantWatering,
                headline: "Set watering cadence",
                highlightValue: "--",
                metrics: [ThreeoMetric(label: "Schedule", value: "Not set", caption: "Create reminder", trend: .steady, systemIcon: "drop")],
                timeline: [],
                footnote: "Stay ahead with consistent watering.",
                lastUpdated: Date(),
                allowsQuickNote: true
            )
        case .plantFertilizing:
            return ThreeoCardSnapshot(
                type: .plantFertilizing,
                headline: "Add feeding plan",
                highlightValue: "--",
                metrics: [ThreeoMetric(label: "Product", value: "--", caption: "Log preferred mix", trend: .steady, systemIcon: "leaf")],
                timeline: [],
                footnote: "Note seasonal adjustments.",
                lastUpdated: Date(),
                allowsQuickNote: true
            )
        case .plantGrowth:
            return ThreeoCardSnapshot(
                type: .plantGrowth,
                headline: "Capture progress",
                highlightValue: "--",
                metrics: [ThreeoMetric(label: "Height", value: "--", caption: "Add measurements", trend: .steady, systemIcon: "ruler")],
                timeline: [],
                footnote: "Photos help visualize growth trends.",
                lastUpdated: Date(),
                allowsQuickNote: true
            )
        }
    }
}
