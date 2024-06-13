//
//  NetworkManager.swift
//  bookstore
//
//  Created by cha on 6/13/24.
//

import Foundation


extension URLSession {
    func data(from url: URL) async throws -> (Data, URLResponse) {
        return try await withCheckedThrowingContinuation { continuation in
            let task = self.dataTask(with: url) { data, response, error in
                if let error = error {
                    continuation.resume(throwing: error)
                } else if let data = data, let response = response {
                    continuation.resume(returning: (data, response))
                } else {
                    continuation.resume(throwing: URLError(.badServerResponse))
                }
            }
            task.resume()
        }
    }
}

class NetworkManager {
    static let shared = NetworkManager()
    
    private let baseURL = "https://api.itbook.store"
    
    private init() {}
    
    func getRequest(path: String) async throws -> Data {
        guard let baseURL = URL(string: baseURL) else {
            throw URLError(.badURL)
        }
        
        let fullURL = baseURL.appendingPathComponent(path)
        let (data, _) = try await URLSession.shared.data(from: fullURL)
        return data
    }
    
    func getRequest<T: Decodable>(path: String, responseType: T.Type) async throws -> T {
        let data = try await self.getRequest(path: path)
        
        let decoder = JSONDecoder()
        do {
            let decodedResponse = try decoder.decode(T.self, from: data)
            return decodedResponse
        } catch {
            throw error
        }
    }
}
