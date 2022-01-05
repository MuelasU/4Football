//
//  APIRequest.swift
//  4Football
//
//  Created by Gabriel Muelas on 21/12/21.
//

import Foundation

protocol APIRequest {
    associatedtype ModelType: Decodable
    var resourcePath: String { get }
    var queries: [String: String]? { get }
    
    func decode(_ data: Data) throws -> [ModelType]
}

extension APIRequest {
    func decode(_ data: Data) throws -> [ModelType] {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        
        let wrapper = try decoder.decode(Wrapper<ModelType>.self, from: data)
//        guard let wrapper = try? decoder.decode(Wrapper<ModelType>.self, from: data) else {
//            throw NetworkError.decodingError
//        }
        
        if let errors = wrapper.errors {
            throw NetworkError.emptyResponse(errors)
        }
        
        return wrapper.response
    }
    
    func buildRequest(baseUrl: String, withHTTPSHeader header: [String:String]? = nil) throws -> URLRequest {
        var urlComponentes = URLComponents(string: baseUrl)
        urlComponentes?.path = resourcePath
        urlComponentes?.queryItems = queries?.map { key, value in
            URLQueryItem(name: key, value: value)
        }
        
        guard
            let urlComponents = urlComponentes,
            let url = urlComponents.url
        else {
            throw NetworkError.badUrl(resourcePath)
        }
        
        var request = URLRequest(url: url)
        if let header = header {
            for (key, value) in header {
                request.addValue(value, forHTTPHeaderField: key)
            }
        }
        
        return request
    }
}
