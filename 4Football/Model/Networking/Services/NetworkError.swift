//
//  NetworkError.swift
//  4Football
//
//  Created by Gabriel Muelas on 21/12/21.
//

import Foundation

enum NetworkError: Error {
    case badUrl(String)
    case badResponse(HTTPURLResponse)
    case noData
    case decodingError
    case emptyResponse([String: String])
}

extension Error {
    var message: String {
        if let networkError = self as? NetworkError {
            switch networkError {
            case .badUrl(let resource):
                return "URL for `\(resource)` could not be constructed"
            case .badResponse(let response):
                return "Server responded badly with code \(response.statusCode)"
            case .noData:
                return "Server returned no data"
            case .decodingError:
                return "Could not decode returned data to model types"
            case .emptyResponse(let errorDict):
                var msg = "Something went wrong on the server:\n"
                for (key, value) in errorDict {
                    msg.append("\(key): \(value)\n")
                }
                return msg
            }
        } else {
            return self.localizedDescription
        }
    }
}
