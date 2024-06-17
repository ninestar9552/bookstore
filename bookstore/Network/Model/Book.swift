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
        return isbn13 ?? "0"
    }
    
    static func ==(lhs: Book, rhs: Book) -> Bool {
        return lhs.id == rhs.id
    }
}
