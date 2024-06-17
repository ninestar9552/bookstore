//
//  BsError.swift
//  bookstore
//
//  Created by cha on 6/17/24.
//

import Foundation

enum BsError: Error {
    case noResults
    
}

extension BsError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .noResults:
            return NSLocalizedString("검색 결과가 없습니다.", comment: "No search results found")
        }
    }
}
