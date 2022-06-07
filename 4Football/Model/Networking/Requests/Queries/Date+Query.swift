//
//  Date.swift
//  4Football
//
//  Created by Gabriel Muelas on 07/06/22.
//

import Foundation

extension Date: Query {
    var key: String {
        "date"
    }
    
    var value: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.string(from: self)
    }
}
