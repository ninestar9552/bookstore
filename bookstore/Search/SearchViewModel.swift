//
//  SearchService.swift
//  bookstore
//
//  Created by cha on 6/13/24.
//

import Foundation


final class SearchViewModel: ObservableObject {
    private let searchService: SearchService
    
    init(searchService: SearchService = SearchService()) {
        self.searchService = searchService
    }
    
    @Published var searchResult: SearchResult = SearchResult()
    @Published var books: [Book] = []
    
    func searchBooks(keyword: String) async throws {
        let _searchResult = try await searchService.searchBook(keyword: keyword)
        await MainActor.run {
            self.searchResult = _searchResult
            self.books = _searchResult.books
        }
    }
}
