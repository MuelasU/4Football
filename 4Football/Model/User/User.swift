import Foundation

struct User: Codable {
    let favoriteClub: Team
    let nationality: Country
    var clubs: Set<Team>
    var leagues: Set<League>
}
