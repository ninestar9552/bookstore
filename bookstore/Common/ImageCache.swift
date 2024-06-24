//
//  ImageCache.swift
//  bookstore
//
//  Created by cha on 6/24/24.
//

import Foundation
import UIKit

class ImageCache {
    static let shared = ImageCache()
    
    private init() {}
    
    private let cache = NSCache<NSString, UIImage>()
    
    func image(forKey key: NSString) -> UIImage? {
        return cache.object(forKey: key)
    }
    
    func setImage(_ image: UIImage, forKey key: NSString) {
        cache.setObject(image, forKey: key)
    }
}
