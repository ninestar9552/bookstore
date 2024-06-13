//
//  SearchService.swift
//  bookstore
//
//  Created by cha on 6/13/24.
//

import Foundation
import Combine


final class SearchService {
    
    let networkManager: NetworkManager
    
    init(networkManager: NetworkManager = NetworkManager.shared) {
        self.networkManager = networkManager
    }
    
    func searchBook(keyword: String, page: Int = 1) async throws -> SearchResult {
        let data = try await networkManager.getRequest(path: "/1.0/search/\(keyword)/\(page)", responseType: SearchResult.self)
        print("응답결과\n\(data)")
        return data
    }
}
