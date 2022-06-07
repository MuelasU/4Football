//
//  FootballAPIClient.swift
//  4Football
//
//  Created by Gabriel Muelas on 21/12/21.
//

import Foundation

class FootballAPIClient: APIClient {
    var baseUrl: String
    var accessToken: [String : String]?
    
    static let shared: FootballAPIClient = {
        let client = FootballAPIClient(url: "https://v3.football.api-sports.io")
        client.accessToken = ["x-rapidapi-key":"786e46f1d1aca9f7250b753a7d034154"]
        return client
    }()
    
    private init(url: String) {
        self.baseUrl = url
    }
}
