//
//  Country.swift
//  4Football
//
//  Created by Gabriel Muelas on 16/09/22.
//

import Foundation
import UIKit

struct Country: Decodable, Item, Equatable {
    let name: String
    let code: String?
    var imageUrl: String? {
        if let code {
            //TODO: load moments before and cache it
            return "https://countryflagsapi.com/png/" + code
        }
        return nil
    }
}
