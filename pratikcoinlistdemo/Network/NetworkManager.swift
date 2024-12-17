//
//  NetworkManager.swift
//  pratikcoinlistdemo
//
//  Created by Pratik Jamariya on 17/12/24.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError(Error)
    case requestFailed(Error)
}

enum HTTPMethod: String {
    case GET
    case POST
    case PUT
    case DELETE
}

final class NetworkManager {
    static let shared = NetworkManager()
    private init() {}
    
    // MARK: - Generic Request Function
    func request<T: Codable>(
        urlString: String,
        method: HTTPMethod = .GET,
        headers: [String: String]? = nil,
        body: Data? = nil,
        completion: @escaping (Result<T, NetworkError>) -> Void
    ) {
        // Create URL
        guard let url = URL(string: urlString) else {
            completion(.failure(.invalidURL))
            return
        }
        
        // Configure Request
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.allHTTPHeaderFields = headers
        request.httpBody = body
        
        // Start Data Task
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(.requestFailed(error)))
                return
            }
            
            guard let data = data else {
                completion(.failure(.noData))
                return
            }
            
            do {
                let decodedResponse = try JSONDecoder().decode(T.self, from: data)
                completion(.success(decodedResponse))
            } catch let decodingError {
                completion(.failure(.decodingError(decodingError)))
            }
        }.resume()
    }
}
