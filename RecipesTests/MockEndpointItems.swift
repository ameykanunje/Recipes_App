//
//  MockEndpointItems.swift
//  RecipesTests
//
//  Created by Amey Kanunje on 10/8/24.
//

import Foundation
@testable import Recipes

enum MockEndpointItems: EndpointType {
    case invalidURL
    case mockRecipes
    
    var path: String {
        switch self {
        case .invalidURL:
            return "/invalid"
        case .mockRecipes:
            return "/mock-recipes.json"
        }
    }
    
    var baseURL: String {
        switch self {
        case .invalidURL:
            return "https://invalid.url"
        case .mockRecipes:
            return "https://mock.api.com"
        }
    }
    
    var url: URL? {
        switch self {
        case .invalidURL:
            return nil
        case .mockRecipes:
            return URL(string: "\(baseURL)\(path)")
        }
    }
}
