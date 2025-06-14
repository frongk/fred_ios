import Foundation

struct FredService {
    let apiKey: String
    private let baseURL = URL(string: "https://api.stlouisfed.org/fred")!

    func searchSeries(text: String) async throws -> [FredSeries] {
        var comps = URLComponents(url: baseURL.appendingPathComponent("series/search"), resolvingAgainstBaseURL: false)!
        comps.queryItems = [
            URLQueryItem(name: "search_text", value: text),
            URLQueryItem(name: "api_key", value: apiKey),
            URLQueryItem(name: "file_type", value: "json")
        ]
        let (data, _) = try await URLSession.shared.data(from: comps.url!)
        let response = try JSONDecoder().decode(SeriesSearchResponse.self, from: data)
        return response.seriess
    }

    func observations(seriesID: String) async throws -> [FredObservation] {
        var comps = URLComponents(url: baseURL.appendingPathComponent("series/observations"), resolvingAgainstBaseURL: false)!
        comps.queryItems = [
            URLQueryItem(name: "series_id", value: seriesID),
            URLQueryItem(name: "api_key", value: apiKey),
            URLQueryItem(name: "file_type", value: "json")
        ]
        let (data, _) = try await URLSession.shared.data(from: comps.url!)
        let response = try JSONDecoder().decode(ObservationsResponse.self, from: data)
        return response.observations
    }
}
