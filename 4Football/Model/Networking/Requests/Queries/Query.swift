//
//  Query.swift
//  4Football
//
//  Created by Gabriel Muelas on 07/06/22.
//

import Foundation

protocol Query {
    var key: String { get }
    var value: String { get }
}

struct GenericQuery: Query {
    var key: String
    var value: String
}
