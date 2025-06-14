import Foundation

struct FredSeries: Codable, Identifiable, Hashable {
    let id: String
    let title: String
}

struct SeriesSearchResponse: Codable {
    let seriess: [FredSeries]
}

struct FredObservation: Codable, Hashable, Identifiable {
    let date: String
    let value: String

    var id: String { date }

    var dateAsDate: Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.date(from: date)
    }
}

struct ObservationsResponse: Codable {
    let observations: [FredObservation]
}
