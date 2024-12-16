//
//  ImageCache.swift
//  Recipes
//
//  Created by Amey Kanunje on 12/15/24.
//

import Foundation
import SwiftUI


protocol ImageCacheProtocol: AnyObject {
    func getImage(for url: URL) async -> UIImage?
    func setImage(for url: URL, _ image: UIImage) async
    func clearCache() async
}

actor ImageCache: ImageCacheProtocol {
    private var cache : [URL : UIImage] = [:]
    
    func getImage(for url: URL) async -> UIImage? {
        return cache[url]
    }
    
    func setImage(for url: URL, _ image: UIImage) async{
        cache[url] = image
    }
    
    func clearCache() async {
        cache.removeAll()
    }
    
    func isCacheEmpty() async -> Bool {
        return cache.isEmpty
    }
}
