//
//  BookItemView.swift
//  bookstore
//
//  Created by cha on 6/17/24.
//

import SwiftUI

struct BookItemView: View {
    let book: Book
    @State private var showSafariView = false
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                GeometryReader { geometry in
                    CachedAsyncImage(
                        url: URL(string: book.image)!,
                        cache: ImageCache.shared,
                        placeholder: {
                            ProgressView()
                                .frame(width: geometry.size.width, height: geometry.size.width)
                        },
                        image: { Image(uiImage: $0).resizable() }
                    )
                    .scaledToFit()
                    .frame(width: geometry.size.width, height: geometry.size.height)
                    .clipped()
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
                    
                    Button(action: {
                        showSafariView.toggle()
                    }) {
                        Text(book.url)
                            .font(.caption)
                            .foregroundColor(.blue)
                    }
                    .sheet(isPresented: $showSafariView) {
                        SafariView(url: URL(string: book.url)!)
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
