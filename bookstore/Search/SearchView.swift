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
            SearchBar(text: $searchText, placeholder: "Search") {
                Task {
                    await viewModel.searchBooks(keyword: searchText)
                }
            }
            List {
                ForEach(viewModel.books) { item in
                    Text(item.title ?? "-")
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
            .alert("Error", isPresented: $viewModel.showErrorAlert) {
                Button("OK", role: .cancel) { }
            } message: {
                Text(viewModel.errorMessage)
            }
        }
    }
}

#Preview {
    SearchView()
}
