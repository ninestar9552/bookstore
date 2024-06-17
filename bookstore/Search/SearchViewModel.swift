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
    @Published var isLoading = false
    @Published var showErrorAlert = false
    @Published var errorMessage = ""
    private var currentPage = 1
    private var totalItems = 0
    private var keyword: String = ""
    
    func searchBooks(keyword: String) async {
        await MainActor.run {
            isLoading = true
        }
        
        do {
            self.keyword = keyword
            let _searchResult = try await searchService.searchBook(keyword: keyword)
            
            if _searchResult.books.isEmpty {
                throw BsError.noResults
            }
            await MainActor.run {
                self.searchResult = _searchResult
                self.books = _searchResult.books
                self.totalItems = Int(_searchResult.total ?? "\(_searchResult.books.count)") ?? _searchResult.books.count
                self.isLoading = false
            }
        } catch {
            await MainActor.run {
                self.errorMessage = error.localizedDescription
                self.showErrorAlert = true
                self.isLoading = false
            }
        }
    }
    
    func loadMoreItems() async {
        print("더불러오기 호출!!")
        guard !isLoading && (books.count < totalItems || books.isEmpty) else {
            print("아직 로딩중 Or 더불러올 것 없음!!")
            return
        }
        
        self.currentPage += 1
        print("더불러오기 실행!! nextPage = \(currentPage)")
        await MainActor.run {
            isLoading = true
        }
        do {
            let _searchResult = try await searchService.searchBook(keyword: self.keyword, page: currentPage)
            await MainActor.run {
                self.searchResult = _searchResult
                self.books.append(contentsOf: _searchResult.books)
                self.isLoading = false
            }
        } catch {
            await MainActor.run {
                self.errorMessage = error.localizedDescription
                self.showErrorAlert = true
                self.isLoading = false
            }
        }
    }
}
