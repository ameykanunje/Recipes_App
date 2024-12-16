//
//  Recipes.swift
//  Recipes
//
//  Created by Amey Kanunje on 12/15/24.
//

import Foundation

// MARK: - Recipes
struct Recipes: Codable, Hashable {
    let recipes: [Recipe]
}

// MARK: - Recipe
struct Recipe: Codable, Hashable {
    let cuisine, name: String
    let photoURLLarge, photoURLSmall: String
    let sourceURL: String?
    let uuid: String
    let youtubeURL: String?

    enum CodingKeys: String, CodingKey {
        case cuisine, name
        case photoURLLarge = "photo_url_large"
        case photoURLSmall = "photo_url_small"
        case sourceURL = "source_url"
        case uuid
        case youtubeURL = "youtube_url"
    }
    
    var photoURLSmallConverted: URL?{
        return URL(string: photoURLSmall)
    }
    
    var youtubeURLConverted: URL? {
        guard let youtubeURLString = youtubeURL else {return nil}
        return URL(string: youtubeURLString)
    }
    
    var sourceURLConverted: URL? {
        guard let sourceURLString = sourceURL else {return nil}
        return URL(string: sourceURLString)
    }
}
