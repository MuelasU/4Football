//
//  Team.swift
//  4Football
//
//  Created by Gabriel Muelas on 21/12/21.
//

import Foundation
import UIKit

struct Team: Identifiable, Decodable {
    let id: Int
    let name: String
    let logoUrl: String
    let winner: Bool?
    
    enum CodingKeys: String, CodingKey {
        case id, name, winner
        case logoUrl = "logo"
    }
}

struct TeamsOfMatch: Decodable {
    let home: Team
    let away: Team
}
