import Foundation

// Get and save user data
class UserSession {
    private(set) var user: User {
        didSet {
            requester.user = user
            saveUser()
        }
    }
    let requester: UserRequestManager

    init(club: Team, nationality: Country) {
        user = .init(favoriteClub: club, nationality: nationality, clubs: [club], leagues: [])
        requester = .init(user: user)
        updateUserLeagues()
    }

    init?() {
        if let data = UserDefaults.standard.data(forKey: "user"),
           let user = try? JSONDecoder().decode(User.self, from: data) {
            self.user = user
            self.requester = .init(user: user)
        } else {
            return nil
        }
    }

    private func saveUser() {
        if let data = try? JSONEncoder().encode(user) {
            UserDefaults.standard.set(data, forKey: "user")
        }
    }

    private func updateUserLeagues() {
        requester.getLeagues { leagues in
            self.user.leagues.formUnion(leagues)
        }
    }

    // MARK: - Interface

    //TODO: Not implemented/tested
    func follow(club: Team) {
        user.clubs.insert(club)
    }

    func follow(league: League) {
        user.leagues.insert(league)
    }
}
