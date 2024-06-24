//
//  Book.swift
//  bookstore
//
//  Created by cha on 6/13/24.
//

import Foundation


// MARK: - Book
struct Book: Codable, Identifiable, Equatable {
    let title, subtitle, isbn13, price: String
    let image: String
    let url: String
    
    var id: String {
        return isbn13
    }
    
    static func ==(lhs: Book, rhs: Book) -> Bool {
        return lhs.id == rhs.id
    }
}

// MARK: - BookDetail
struct BookDetail: Codable, Identifiable, Equatable {
    let error, title, subtitle, authors: String
    let publisher, isbn10, isbn13, pages: String
    let year, rating, desc, price: String
    let image: String
    let url: String
    let pdf: [String:String]?
    
    var id: String {
        return isbn13
    }
    
    static func ==(lhs: BookDetail, rhs: BookDetail) -> Bool {
        return lhs.id == rhs.id
    }
}
