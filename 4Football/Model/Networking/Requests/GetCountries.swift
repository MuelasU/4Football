//
//  GetCountries.swift
//  4Football
//
//  Created by Gabriel Muelas on 16/09/22.
//

import Foundation

struct GetCountries: APIRequest {
    typealias ModelType = Country

    let resourcePath: String = "/countries"
    let queries: [String : String]?

    init(by filters: [Query]? = nil) {
        var queries : [String : String] = [:]
        filters?.forEach { queries[$0.key] = $0.value }
        self.queries = queries.isEmpty ? nil : queries
    }
}
