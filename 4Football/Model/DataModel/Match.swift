//
//  Match.swift
//  4Football
//
//  Created by Gabriel Muelas on 21/12/21.
//

import Foundation

struct Match: Decodable {
    let teams: TeamsOfMatch
    let goals: Score?
}

struct Score: Decodable {
    let home: Int
    let away: Int
}
