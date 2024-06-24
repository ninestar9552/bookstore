//
//  SearchResult.swift
//  bookstore
//
//  Created by cha on 6/13/24.
//

import Foundation


// MARK: - SearchResult
struct SearchResult: Codable {
    var error: String? = nil
    var total: String? = nil
    var page: String? = nil
    var books: [Book] = []
}
