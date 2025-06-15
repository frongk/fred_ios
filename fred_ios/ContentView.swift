import Charts
import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = SearchViewModel()
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(viewModel.results) { series in
                    NavigationLink(series.title) {
                        SeriesDetailView(series: series)
                    }
                }
            }
            .navigationTitle("FRED Browser")
            .searchable(text: $viewModel.query)
            .onChange(of: viewModel.query) { newValue in
                Task { await viewModel.search() }
            }
        }
    }
}

final class SearchViewModel: ObservableObject {
    @Published var query: String = ""
    @Published var results: [FredSeries] = []
    
    func search() async {
        do {
            let results = try await FredAPI.shared.searchSeries(query: query)
            await MainActor.run { self.results = results }
        } catch {
            print("Search error", error)
        }
    }
}

struct SeriesDetailView: View {
    let series: FredSeries
    @State private var observations: [Observation] = []
    
    var body: some View {
        ScrollView {
            if observations.isEmpty {
                ProgressView()
                    .task { await load() }
            } else {
                Chart(observations) { obs in
                    if let value = Double(obs.value) {
                        LineMark(
                            x: .value("Date", obs.date),
                            y: .value("Value", value)
                        )
                    }
                }
                .frame(height: 300)
                .padding()
            }
        }
        .navigationTitle(series.title)
    }
    
    private func load() async {
        do {
            let obs = try await FredAPI.shared.observations(for: series)
            await MainActor.run { self.observations = obs }
        } catch {
            print("Obs error", error)
        }
    }
}

#Preview {
    ContentView()
}
