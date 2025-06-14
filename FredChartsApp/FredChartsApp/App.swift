import SwiftUI

@main
struct FredChartsApp: App {
    var body: some Scene {
        WindowGroup {
            SeriesListView(service: FredService(apiKey: "YOUR_API_KEY_HERE"))
        }
    }
}
