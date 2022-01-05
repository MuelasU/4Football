//
//  APIClient.swift
//  4Football
//
//  Created by Gabriel Muelas on 21/12/21.
//

import Foundation

protocol APIClient {
    var baseUrl: String { get }
    var accessToken: [String: String]? { get }
    
    func send<Request: APIRequest>(
        _ request: Request,
        completion: @escaping (Result<[Request.ModelType], Error>) -> Void
    )
}

extension APIClient {
    func send<Request: APIRequest>(
        _ request: Request,
        completion: @escaping (Result<[Request.ModelType], Error>) -> Void
    ) {
        do {
            let req = try request.buildRequest(baseUrl: baseUrl, withHTTPSHeader: accessToken)
            
            let task = URLSession.shared.dataTask(with: req) { data, res, error in
                do {
                    if let error = error {
                        throw error
                    }
                    
                    if let httpsResponse = res as? HTTPURLResponse,
                        httpsResponse.statusCode != 200 {
                        throw NetworkError.badResponse(httpsResponse)
                    }
                    
                    guard let data = data else {
                        throw NetworkError.noData
                    }
                    
                    let modelData = try request.decode(data)
                    DispatchQueue.main.async {
                        completion(.success(modelData))
                        return
                    }
                } catch {
                    print(error)
                    DispatchQueue.main.async {
                        completion(.failure(error))
                        return
                    }
                }
            }
            task.resume()
        }
        catch {
            completion(.failure(error))
            return
        }
    }
}
