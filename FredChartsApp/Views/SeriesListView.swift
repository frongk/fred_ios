import SwiftUI

struct SeriesListView: View {
    @State private var query: String = ""
    @State private var results: [FredSeries] = []
    let service: FredService

    var body: some View {
        NavigationStack {
            List(results) { series in
                NavigationLink(value: series) {
                    Text(series.title)
                }
            }
            .navigationDestination(for: FredSeries.self) { series in
                SeriesDetailView(service: service, series: series)
            }
            .navigationTitle("FRED Search")
            .searchable(text: $query)
            .onSubmit(of: .search) {
                Task { await search() }
            }
        }
    }

    @MainActor
    func search() async {
        do {
            results = try await service.searchSeries(text: query)
        } catch {
            print("Search failed: \(error)")
        }
    }
}

#Preview {
    SeriesListView(service: .init(apiKey: "DEMO_KEY"))
}
