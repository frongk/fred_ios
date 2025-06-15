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
            .navigationTitle("Unofficial FRED Browser")
            .navigationBarTitleDisplayMode(.inline)
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
    @State private var info: SeriesInfo?

    var body: some View {
        ScrollView {
            if observations.isEmpty {
                ProgressView()
                    .task { await load() }
            } else {
                VStack(alignment: .leading) {
                    LineChart(observations: observations, yAxisLabel: series.units)
                        .frame(height: 300)
                        .padding()
                    if let info = info {
                        Text(info.notes)
                            .font(.footnote)
                            .padding([.horizontal])
                        Link("View on FRED", destination: URL(string: "https://fred.stlouisfed.org/series/\(series.id)")!)
                            .font(.footnote)
                            .padding([.horizontal, .bottom])
                    }
                }
            }
        }
        .navigationTitle(series.title)
        .navigationBarTitleDisplayMode(.inline)
    }

    private func load() async {
        do {
            async let obs = FredAPI.shared.observations(for: series)
            async let meta = FredAPI.shared.seriesInfo(id: series.id)
            let (o, m) = try await (obs, meta)
            await MainActor.run {
                self.observations = o
                self.info = m
            }
        } catch {
            print("Obs error", error)
        }
    }
}

#Preview {
    ContentView()
}
