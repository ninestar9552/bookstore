//
//  BookDetailBiew.swift
//  bookstore
//
//  Created by cha on 6/24/24.
//

import SwiftUI

struct BookDetailView: View {
    var isbn13: String
    @StateObject var viewModel: BookDetailViewModel
    
    @State private var showSafariView = false
    
    init(bookDetailService: BookDetailService = BookDetailService(), isbn13: String) {
        self._viewModel = StateObject(wrappedValue: BookDetailViewModel(bookDetailService: bookDetailService))
        self.isbn13 = isbn13
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                if let imageUrl = URL(string: viewModel.bookDetail.image) {
                    CachedAsyncImage(
                        url: imageUrl,
                        cache: ImageCache.shared,
                        placeholder: {
                            ProgressView()
                        },
                        image: { Image(uiImage: $0).resizable() }
                    )
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: .infinity)
                    .clipped()
                } else {
                    ProgressView()
                        .frame(height: 200)
//                    Image(systemName: "photo")
//                        .resizable()
//                        .scaledToFit()
//                        .frame(width: geometry.size.width, height: geometry.size.width)
                }
                
                Group {
                    Text(viewModel.bookDetail.title)
                        .font(.title)
                        .fontWeight(.bold)
                    
                    Text(viewModel.bookDetail.subtitle)
                        .font(.title3)
                        .foregroundColor(.gray)
                    
                    Text("By \(viewModel.bookDetail.authors)")
                        .font(.headline)
                    
                    Text("Publisher: \(viewModel.bookDetail.publisher)")
                        .font(.subheadline)
                    
                    Text("ISBN-10: \(viewModel.bookDetail.isbn10)")
                        .font(.subheadline)
                    
                    Text("ISBN-13: \(viewModel.bookDetail.isbn13)")
                        .font(.subheadline)
                    
                    Text("Pages: \(viewModel.bookDetail.pages)")
                        .font(.subheadline)
                    
                    Text("Year: \(viewModel.bookDetail.year)")
                        .font(.subheadline)
                    
                    Text("Rating: \(viewModel.bookDetail.rating)")
                        .font(.subheadline)
                }
                
                Text(viewModel.bookDetail.desc)
                    .font(.body)
                
                Text("Price: \(viewModel.bookDetail.price)")
                    .font(.title2)
                    .fontWeight(.bold)
                
                ForEach(viewModel.bookDetail.pdf?.sorted(by: >) ?? [:].sorted(by: >), id: \.key) { key, value in
                    if let url = URL(string: value) {
                        Button(action: {
                            showSafariView.toggle()
                        }) {
                            Text("\(key) PDF")
                                .font(.caption)
                                .foregroundColor(.blue)
                        }
                        .sheet(isPresented: $showSafariView) {
                            SafariView(url: url)
                        }
                    }
                }
                
                Spacer()
            }
            .padding()
        }
        .navigationTitle(viewModel.bookDetail.title)
        .task {
            Task {
                await viewModel.getBookDetail(isbn13: isbn13)                
            }
        }
    }
}


#Preview {
    BookDetailView(isbn13: "9781617294136")
}
