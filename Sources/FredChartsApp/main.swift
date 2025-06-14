import SwiftUI

@available(iOS 16.0, macOS 13.0, *)
@main
struct FredChartsApp: App {
    @StateObject private var state = AppState(apiKey: ProcessInfo.processInfo.environment["FRED_API_KEY"] ?? "")
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(state)
        }
    }
}
