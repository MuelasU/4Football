import Foundation

// Contact API
class UserRequestManager {
    var user: User
    private let semaphore: DispatchSemaphore
    private let queue: DispatchQueue = .init(label: "requester")

    init(user: User) {
        self.user = user
        semaphore = .init(value: 0)
        semaphore.signal()
    }

    private func getSeason(from league: League, completion: @escaping (Result<Season, Error>) -> Void) {
        queue.async {
            self.semaphore.wait()
            let current = GenericQuery(key: "current", value: "true")
            let leagueId = GenericQuery(key: "id", value: String(league.id))
            let request = GetLeagues(by: [leagueId, current])
            FootballAPIClient.shared.send(request) { response in
                switch response {
                case .success(let leaguesWrapper):
                    completion(.success(leaguesWrapper[0].seasons[0]))
                case .failure(let error):
                    completion(.failure(error))
                }
                self.semaphore.signal()
            }
        }
    }

    func getLeagues(_ completion: @escaping (Set<League>) -> Void) {
        queue.async {
            self.semaphore.wait()
            let group = DispatchGroup()
            var leagues = Set<League>()
            let fmt = DateFormatter()
            fmt.dateFormat = "yyyy"
            self.user.clubs.forEach { club in
                group.enter()
                let current = GenericQuery(key: "current", value: "true")
                let request = GetLeagues(by: [club, current])
                FootballAPIClient.shared.send(request) { response in
                    switch response {
                    case .success(let leaguesWrapper):
                        leagues.formUnion(leaguesWrapper.compactMap { $0.league })
                        group.leave()
                    case .failure(let error):
                        print(error.message)
                        group.leave()
                    }
                }
            }

            group.notify(queue: .main) {
                completion(leagues)
                self.semaphore.signal()
            }
        }
    }

    func getMatches(from day: Date, completion: @escaping ([Match]) -> Void) {
        queue.async {
            self.semaphore.wait()
            let group = DispatchGroup()
            var matches = [Match]()
            for league in self.user.leagues {
                print(league.name)
                group.enter()
                self.semaphore.signal()
                self.getSeason(from: league) { res in
                    switch res {
                    case .success(let season):
                        let req = GetMatches(by: [day, season, league])
                        FootballAPIClient.shared.send(req) { res in
                            switch res {
                            case .success(let matchesArray):
                                matches.append(contentsOf: matchesArray)
                                group.leave()
                            case .failure(let error):
                                print(error)
                                group.leave()
                            }
                        }
                    case .failure(let error):
                        print(error)
                        group.leave()
                    }
                }
            }

            group.notify(queue: .main) {
                completion(matches)
                self.semaphore.signal()
            }
        }
    }
}
