import SwiftUI
import Charts

struct SeriesDetailView: View {
    let service: FredService
    let series: FredSeries
    @State private var observations: [FredObservation] = []

    var body: some View {
        ScrollView {
            Chart(observations) { obs in
                if let value = Double(obs.value),
                   let date = obs.dateAsDate {
                    LineMark(
                        x: .value("Date", date),
                        y: .value("Value", value)
                    )
                }
            }
            .frame(height: 300)
            .padding()
        }
        .navigationTitle(series.id)
        .task {
            await loadData()
        }
    }

    @MainActor
    func loadData() async {
        do {
            observations = try await service.observations(seriesID: series.id)
        } catch {
            print("Failed to load observations: \(error)")
        }
    }
}

#Preview {
    SeriesDetailView(service: .init(apiKey: "DEMO_KEY"), series: .init(id: "UNRATE", title: "Unemployment Rate"))
}
