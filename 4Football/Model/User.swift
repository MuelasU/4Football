import Foundation

struct User: Codable {
    let favoriteClub: Team
    let nationality: Country
    let clubs: [Team]
    let leagues: [League]
}

class UserSession {
    var user: User {
        didSet {
            saveUser()
        }
    }

    init(club: Team, nationality: Country) {
        user = .init(favoriteClub: club, nationality: nationality, clubs: [club], leagues: [])
    }

    init?() {
        if let data = UserDefaults.standard.data(forKey: "user"),
           let user = try? JSONDecoder().decode(User.self, from: data) {
            self.user = user
        } else {
            return nil
        }
    }

    private func saveUser() {
        if let data = try? JSONEncoder().encode(user) {
            UserDefaults.standard.set(data, forKey: "user")
        }
    }
}
