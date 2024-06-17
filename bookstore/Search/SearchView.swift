//
//  SearchView.swift
//  bookstore
//
//  Created by cha on 6/13/24.
//

import SwiftUI

struct SearchView: View {
    @StateObject var viewModel: SearchViewModel
    
    @State private var searchText = ""
    
    init(searchService: SearchService = SearchService()) {
        self._viewModel = StateObject(wrappedValue: SearchViewModel(searchService: searchService))
    }
    
    var body: some View {
        VStack {
            SearchBarView(text: $searchText, placeholder: "Search") {
                Task {
                    await viewModel.searchBooks(keyword: searchText)
                }
            }
            List {
                ForEach(viewModel.books) { item in
                    BookItemView(book: item)
                        .onAppear {
                            if item == viewModel.books.last {
                                print("마지막 아이템 onAppear\ntitle = \(String(describing: item.title))\nlast  = \(String(describing: viewModel.books.last?.title))")
                                Task {
                                    await viewModel.loadMoreItems()
                                }
                            }
                        }
                }
                
                if viewModel.isLoading {
                    ProgressView()
                }
            }
            .listStyle(PlainListStyle()) // 좌우 여백 제거
            .listRowInsets(EdgeInsets()) // ItemView 여백 제거
            .alert(viewModel.errorMessage, isPresented: $viewModel.showErrorAlert) {
                Button("OK", role: .cancel) { }
            }
        }
    }
}

#Preview {
    SearchView()
}
