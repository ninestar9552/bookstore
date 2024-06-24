//
//  ImageLoader.swift
//  bookstore
//
//  Created by cha on 6/24/24.
//

import Foundation
import SwiftUI

class ImageLoader: ObservableObject {
    @Published var image: UIImage?
    private let url: URL
    private var cache: ImageCache?
    
    init(url: URL, cache: ImageCache? = nil) {
        self.url = url
        self.cache = cache
        self.loadImage()
    }
    
    func loadImage() {
        if let cache = cache, let cachedImage = cache.image(forKey: url.absoluteString as NSString) {
            self.image = cachedImage
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, let loadedImage = UIImage(data: data) else {
                return
            }
            
            DispatchQueue.main.async {
                if let cache = self.cache {
                    cache.setImage(loadedImage, forKey: self.url.absoluteString as NSString)
                }
                self.image = loadedImage
            }
        }
        
        task.resume()
    }
}
