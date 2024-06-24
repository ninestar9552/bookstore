//
//  BookDetailService.swift
//  bookstore
//
//  Created by cha on 6/24/24.
//

import Foundation
import Combine


final class BookDetailService {
    
    let networkManager: NetworkManager
    
    init(networkManager: NetworkManager = NetworkManager.shared) {
        self.networkManager = networkManager
    }
    
    func getBookDetail(isbn13: String) async throws -> BookDetail {
        print("북상세 조회 요청 \(isbn13)")
        let data = try await networkManager.getRequest(path: "/1.0/books/\(isbn13)", responseType: BookDetail.self)
        print("북상세 응답 결과 \(isbn13)\n\(data)")
        return data
    }
}
