//
//  Wrapper.swift
//  4Football
//
//  Created by Gabriel Muelas on 22/12/21.
//

import Foundation

struct Wrapper<T: Decodable>: Decodable {
    let response: [T]
    let errors: [String: String]?
    
    private enum CodingKeys: String, CodingKey {
        case response, errors
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        response = try values.decode([T].self, forKey: .response)
        errors = try? values.decode([String: String].self, forKey: .errors)
    }
}


