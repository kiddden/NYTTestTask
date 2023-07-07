//
//  ImageCache.swift
//  NYTTestTask
//
//  Created by Eugene Ned on 07.07.2023.
//

import Foundation
import UIKit

class ImageCache {
    private var cache = NSCache<NSString, UIImage>()
    
    func cache(image: UIImage, for key: String) {
        cache.setObject(image, forKey: key as NSString)
    }
    
    func image(for key: String) -> UIImage? {
        return cache.object(forKey: key as NSString)
    }
}
