import Foundation

struct League: Identifiable, Decodable, Hashable, Item {
    let id: Int
    let name: String
//    let country: String
    let imageUrl: String?
    let season: Int
    let round: String
    
    enum CodingKeys: String, CodingKey {
        case id, name, season, round
        case imageUrl = "logo"
    }
    
}
