//
//  Country+Query.swift
//  4Football
//
//  Created by Gabriel Muelas on 06/03/23.
//

import Foundation

extension Country: Query {
    var key: String {
        "country"
    }

    var value: String {
        self.name
    }
}
