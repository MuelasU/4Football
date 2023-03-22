import Foundation

struct GetLeagues: APIRequest {
    typealias ModelType = LeagueWrapper

    var resourcePath: String = "/leagues"
    var queries: [String : String]?

    init(by filters: [Query]? = nil) {
        var queries : [String : String] = [:]
        filters?.forEach { queries[$0.key] = $0.value }
        self.queries = queries.isEmpty ? nil : queries
    }
}
