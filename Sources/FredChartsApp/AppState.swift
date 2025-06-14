import Foundation
import SwiftUI

@available(macOS 10.15, *)
@MainActor
class AppState: ObservableObject {
    @Published var searchText: String = ""
    @Published var seriesList: [FREDSeries] = []
    @Published var selectedSeries: FREDSeries?
    @Published var observations: [FREDObservation] = []
    
    private let client: FREDClient
    
    init(apiKey: String) {
        client = FREDClient(apiKey: apiKey)
    }
    
    func search() async {
        guard !searchText.isEmpty else { return }
        do {
            seriesList = try await client.searchSeries(query: searchText)
        } catch {
            print("Search error: \(error)")
        }
    }
    
    func load(series: FREDSeries) async {
        selectedSeries = series
        do {
            observations = try await client.fetchObservations(seriesID: series.seriesID)
        } catch {
            print("Observation error: \(error)")
        }
    }
}
