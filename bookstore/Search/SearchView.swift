//
//  SearchView.swift
//  bookstore
//
//  Created by cha on 6/13/24.
//

import SwiftUI

struct SearchView: View {
    @StateObject var viewModel: SearchViewModel
    
    init(searchService: SearchService = SearchService()) {
        self._viewModel = StateObject(wrappedValue: SearchViewModel(searchService: searchService))
    }
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
        .task {
            try? await viewModel.searchBooks(keyword: "mongoDB")
        }
    }
}

#Preview {
    SearchView()
}
