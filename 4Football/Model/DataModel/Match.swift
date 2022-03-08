//
//  Match.swift
//  4Football
//
//  Created by Gabriel Muelas on 21/12/21.
//

import Foundation

struct Match: Decodable {
    let teams: TeamsOfMatch
    let goals: Score
    let league: League
    let fixture: MatchInfo
}

struct Score: Decodable {
    let home: Int?
    let away: Int?
}

struct MatchInfo: Decodable, Identifiable {
    let id: Int
    let status: MatchState
    let date: Date
    let time: Int?
    
    enum CodingKeys: String, CodingKey {
        case id, status, date
    }
    
    enum StatusCodingKeys: String, CodingKey {
        case short, elapsed
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        date = try container.decode(Date.self, forKey: .date)
        let statusContainer = try container.nestedContainer(keyedBy: StatusCodingKeys.self, forKey: .status)
        status = try statusContainer.decode(MatchState.self, forKey: .short)
        time = try statusContainer.decode(Int?.self, forKey: .elapsed)
    }
}

enum MatchState: String, Decodable {
    case notStarted = "NS"
    case firstHalf = "1H"
    case halftime = "HT"
    case secondHalf = "2H"
    case finished = "FT"
    case extraTime = "ET"
    case penalties = "P"
    case toBeDefined = "TBD"
    case cancelled = "CANC"
    
    var hasScore: Bool {
        get {
            switch self {
            case .cancelled, .toBeDefined, .notStarted:
                return false
            default:
                return true
            }
        }
    }
}
