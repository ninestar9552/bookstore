//
//  CachedAsyncImage.swift
//  bookstore
//
//  Created by cha on 6/24/24.
//

import SwiftUI

struct CachedAsyncImage<Placeholder: View>: View {
    @StateObject private var loader: ImageLoader
    private let placeholder: Placeholder
    private let image: (UIImage) -> Image

    init(url: URL, cache: ImageCache? = nil, @ViewBuilder placeholder: () -> Placeholder, @ViewBuilder image: @escaping (UIImage) -> Image = Image.init(uiImage:)) {
        self._loader = StateObject(wrappedValue: ImageLoader(url: url, cache: cache))
        self.placeholder = placeholder()
        self.image = image
    }

    var body: some View {
        content
            .onAppear(perform: loader.loadImage)
    }

    private var content: some View {
        Group {
            if let uiImage = loader.image {
                image(uiImage)
            } else {
                placeholder
            }
        }
    }
}
