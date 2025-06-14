import Foundation

struct FREDSeries: Identifiable, Decodable {
    var id: String { seriesID }
    let seriesID: String
    let title: String
    
    enum CodingKeys: String, CodingKey {
        case seriesID = "id"
        case title
    }
}

struct FREDObservation: Identifiable, Decodable {
    var id: String { date }
    let date: String
    let value: String
}

struct FREDSearchResponse: Decodable {
    let seriess: [FREDSeries]
}

struct FREDObservationsResponse: Decodable {
    let observations: [FREDObservation]
}

@available(iOS 16.0, macOS 12.0, *)
class FREDClient {
    private let apiKey: String
    private let session: URLSession
    
    init(apiKey: String, session: URLSession = .shared) {
        self.apiKey = apiKey
        self.session = session
    }
    
    func searchSeries(query: String) async throws -> [FREDSeries] {
        guard var comps = URLComponents(string: "https://api.stlouisfed.org/fred/series/search") else {
            return []
        }
        comps.queryItems = [
            URLQueryItem(name: "search_text", value: query),
            URLQueryItem(name: "api_key", value: apiKey),
            URLQueryItem(name: "file_type", value: "json")
        ]
        let (data, _) = try await session.data(from: comps.url!)
        let response = try JSONDecoder().decode(FREDSearchResponse.self, from: data)
        return response.seriess
    }
    
    func fetchObservations(seriesID: String) async throws -> [FREDObservation] {
        guard var comps = URLComponents(string: "https://api.stlouisfed.org/fred/series/observations") else {
            return []
        }
        comps.queryItems = [
            URLQueryItem(name: "series_id", value: seriesID),
            URLQueryItem(name: "api_key", value: apiKey),
            URLQueryItem(name: "file_type", value: "json")
        ]
        let (data, _) = try await session.data(from: comps.url!)
        let response = try JSONDecoder().decode(FREDObservationsResponse.self, from: data)
        return response.observations
    }
}
