import SwiftUI
import FredChartsApp

@main
struct PreviewHostApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(AppState(apiKey: "demo"))
        }
    }
}
