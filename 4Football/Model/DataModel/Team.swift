//
//  Team.swift
//  4Football
//
//  Created by Gabriel Muelas on 21/12/21.
//

import Foundation
import UIKit

struct Team: Identifiable, Decodable, Item {
    let id: Int
    let name: String
    let imageUrl: String?
    let winner: Bool?
    
    enum CodingKeys: String, CodingKey {
        case id, name, winner
        case imageUrl = "logo"
    }
}

struct TeamsOfMatch: Decodable {
    let home: Team
    let away: Team
}
