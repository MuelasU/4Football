import Foundation

struct League: Identifiable, Decodable, Hashable {
    let id: Int
    let name: String
//    let country: String
    let logoUrl: String
    let season: Int
    let round: String
    
    enum CodingKeys: String, CodingKey {
        case id, name, season, round
        case logoUrl = "logo"
    }
    
}
