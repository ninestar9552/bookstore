//
//  Book.swift
//  bookstore
//
//  Created by cha on 6/13/24.
//

import Foundation


// MARK: - Book
struct Book: Codable {
    let title, subtitle, isbn13, price: String?
    let image: String?
    let url: String?
}
