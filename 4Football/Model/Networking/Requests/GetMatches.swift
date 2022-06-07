//
//  GetMatches.swift
//  4Football
//
//  Created by Gabriel Muelas on 21/12/21.
//

import Foundation

struct GetMatches: APIRequest {
    typealias ModelType = Match

    let resourcePath: String = "/fixtures"
    let queries: [String : String]?
    
    init(by filters: [String : String]? = nil) {
        queries = filters
    }
    
    init(by filters: [Query]? = nil) {
        var queries : [String : String] = [:]
        filters?.forEach { queries[$0.key] = $0.value }
        self.queries = queries.isEmpty ? nil : queries
    }
}
