import Foundation
import SwiftUI

// Model representing a FRED series search result
struct FredSeries: Identifiable, Decodable {
    let id: String
    let title: String
    let frequency: String
    let units: String
    let lastUpdated: String
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case title
        case frequency
        case units
        case lastUpdated = "last_updated"
    }
}

struct SeriesSearchResponse: Decodable {
    let seriess: [FredSeries]
}

struct Observation: Decodable, Identifiable {
    let id = UUID()
    let date: String
    let value: String
    
    enum CodingKeys: String, CodingKey {
        case date
        case value
    }
}

struct ObservationsResponse: Decodable {
    let observations: [Observation]
}

final class FredAPI {
    static let shared = FredAPI()
    private init() {}
    
    // Replace with your own FRED API key
    private let apiKey = "YOUR_API_KEY"
    
    func searchSeries(query: String) async throws -> [FredSeries] {
        guard !query.isEmpty else { return [] }
        var components = URLComponents(string: "https://api.stlouisfed.org/fred/series/search")!
        components.queryItems = [
            URLQueryItem(name: "search_text", value: query),
            URLQueryItem(name: "api_key", value: apiKey),
            URLQueryItem(name: "file_type", value: "json"),
            URLQueryItem(name: "limit", value: "50")
        ]
        let (data, _) = try await URLSession.shared.data(from: components.url!)
        let decoded = try JSONDecoder().decode(SeriesSearchResponse.self, from: data)
        return decoded.seriess
    }
    
    func observations(for series: FredSeries) async throws -> [Observation] {
        var components = URLComponents(string: "https://api.stlouisfed.org/fred/series/observations")!
        components.queryItems = [
            URLQueryItem(name: "series_id", value: series.id),
            URLQueryItem(name: "api_key", value: apiKey),
            URLQueryItem(name: "file_type", value: "json")
        ]
        let (data, _) = try await URLSession.shared.data(from: components.url!)
        let decoded = try JSONDecoder().decode(ObservationsResponse.self, from: data)
        return decoded.observations
    }
}
