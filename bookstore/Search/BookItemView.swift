//
//  BookItemView.swift
//  bookstore
//
//  Created by cha on 6/17/24.
//

import SwiftUI

struct BookItemView: View {
    let book: Book
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                GeometryReader { geometry in
                    AsyncImage(url: URL(string: book.image)) { phase in
                        switch phase {
                        case .empty:
                            ProgressView()
                                .frame(width: geometry.size.width, height: geometry.size.width)
                        case .success(let image):
                            image
                                .resizable()
                                .scaledToFit() // 이미지가 잘리지 않고 여백 없이 채우도록 설정
                                .frame(width: geometry.size.width, height: geometry.size.height)
                                .clipped()
                        case .failure:
                            Image(systemName: "photo")
                                .resizable()
                                .scaledToFit() // 여백 없이 채우도록 설정
                                .frame(width: geometry.size.width, height: geometry.size.width)
                        @unknown default:
                            EmptyView()
                        }
                    }
                }
                .aspectRatio(1, contentMode: .fit)
                .frame(width: 100, height: 117)
                
                VStack(alignment: .leading) {
                    Text(book.title)
                        .font(.headline)
                    Text(book.subtitle)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    Text("ISBN13: \(book.isbn13)")
                        .font(.caption)
                    Text("Price: \(book.price)")
                        .font(.caption)
                    Link(destination: URL(string: book.url)!) {
                        Text(book.url)
                            .font(.caption)
                            .foregroundColor(.blue)
                    }
                }
                .padding(.leading, 8)
            }
        }
        .padding()
    }
}



#Preview {
    BookItemView(book: Book(
        title: "MongoDB in Action, 2nd Edition",
        subtitle: "Covers MongoDB version 3.0",
        isbn13: "9781617291609",
        price: "$19.99",
        image: "https://itbook.store/img/books/9781617291609.png",
        url: "https://itbook.store/books/9781617291609"))
}
