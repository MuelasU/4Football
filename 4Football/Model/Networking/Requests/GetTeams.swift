//
//  GetTeams.swift
//  4Football
//
//  Created by Gabriel Muelas on 06/03/23.
//

import Foundation

struct GetTeams: APIRequest {
    typealias ModelType = TeamWrapper

    var resourcePath: String = "/teams"
    var queries: [String : String]?

    init(by filters: [Query]? = nil) {
        var queries : [String : String] = [:]
        filters?.forEach { queries[$0.key] = $0.value }
        self.queries = queries.isEmpty ? nil : queries
    }
}
