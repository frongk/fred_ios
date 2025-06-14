import SwiftUI

@main
struct FredChartsApp: App {
    @StateObject private var state = AppState(apiKey: ProcessInfo.processInfo.environment["FRED_API_KEY"] ?? "")
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(state)
        }
    }
}
