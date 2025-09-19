import SwiftUI

@main
struct ThreeoApp: App {
    @StateObject private var dataStore = ThreeoDataStore()

    var body: some Scene {
        WindowGroup {
            HomeView()
                .environmentObject(dataStore)
        }
    }
}
