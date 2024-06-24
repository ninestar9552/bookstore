//
//  BookDetailViewModel.swift
//  bookstore
//
//  Created by cha on 6/24/24.
//

import Foundation


final class BookDetailViewModel: ObservableObject {
    
    private let bookDetailService: BookDetailService
    
    init(bookDetailService: BookDetailService = BookDetailService()) {
        self.bookDetailService = bookDetailService
    }
    
    @Published var bookDetail: BookDetail = BookDetail(
        error: "",
        title: "",
        subtitle: "",
        authors: "",
        publisher: "",
        isbn10: "",
        isbn13: "",
        pages: "",
        year: "",
        rating: "",
        desc: "",
        price: "",
        image: "",
        url: "",
        pdf: [:]
    )
    @Published var isLoading = false
    @Published var showErrorAlert = false
    @Published var errorMessage = ""
    
    
    func getBookDetail(isbn13: String) async {
        print("BookDetailViewModel:: 책 상세 조회 \(isbn13)")
        await MainActor.run {
            isLoading = true
        }
        
        do {
            let _bookDetail = try await bookDetailService.getBookDetail(isbn13: isbn13)
            
            await MainActor.run {
                self.bookDetail = _bookDetail
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
