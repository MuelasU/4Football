import Foundation

struct League: Identifiable, Codable, Hashable, Item {
    let id: Int
    let name: String
    let imageUrl: String?
    let season: Int?
    let round: String?
    
    enum CodingKeys: String, CodingKey {
        case id, name, season, round
        case imageUrl = "logo"
    }
}

struct LeagueWrapper: Decodable {
    let league: League
    let seasons: [Season]
}

struct Season: Codable, Query {
    var key: String { "season" }
    var value: String { String(year) }

    let year: Int
}
