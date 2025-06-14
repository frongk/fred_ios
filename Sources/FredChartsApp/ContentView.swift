import SwiftUI
import Charts

struct ContentView: View {
    @EnvironmentObject var state: AppState
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    TextField("Search", text: $state.searchText)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    Button("Go") {
                        Task { await state.search() }
                    }
                }.padding()
                List(state.seriesList) { series in
                    NavigationLink(destination: SeriesDetailView(series: series)) {
                        VStack(alignment: .leading) {
                            Text(series.title)
                            Text(series.seriesID).font(.caption).foregroundColor(.secondary)
                        }
                    }
                }
            }
            .navigationTitle("FRED Browser")
        }
    }
}

struct SeriesDetailView: View {
    @EnvironmentObject var state: AppState
    let series: FREDSeries
    var body: some View {
        ScrollView {
            if state.selectedSeries?.seriesID != series.seriesID {
                ProgressView().task {
                    await state.load(series: series)
                }
            } else {
                Chart(state.observations) {
                    LineMark(
                        x: .value("Date", $0.date),
                        y: .value("Value", Double($0.value) ?? 0)
                    )
                }
                .chartXAxisLabel("Date")
                .chartYAxisLabel("Value")
                .frame(height: 300)
            }
        }
        .navigationTitle(series.title)
    }
}

#Preview {
    ContentView().environmentObject(AppState(apiKey: "demo"))
}
