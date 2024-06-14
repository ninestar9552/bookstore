//
//  SearchBar.swift
//  bookstore
//
//  Created by cha on 6/14/24.
//

import SwiftUI

struct SearchBar: View {
    @Binding var text: String
    var placeholder: String
    var onSearchButtonClicked: () -> Void
    
    var body: some View {
        HStack {
            TextField(placeholder, text: $text)
                .padding(.horizontal, 24)
                .frame(height: 40)
            Button(action: {
                onSearchButtonClicked()
            }) {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.gray)
            }
            .padding(.trailing, 8)
        }
        .background(Color(.systemGray5))
        .cornerRadius(8)
        .padding(EdgeInsets(top: 10, leading: 15, bottom: 5, trailing: 15))
    }
}


#Preview {
    SearchBar(text: .constant(""), placeholder: "Search") {
        
    }
}
