//
//  EndpointType.swift
//  Recipes
//
//  Created by Amey Kanunje on 12/15/24.
//

import Foundation

protocol EndpointType{
    var path: String{get}
    var baseURL: String{get}
    var url: URL?{get}
}

enum EndpointItems{
    case Recipes
}

extension EndpointItems : EndpointType{
    var path: String {
        switch self{
        case .Recipes:
            return "/recipes.json"
        }
    }
    
    var baseURL: String {
        return "https://d3jbb8n5wk0qxi.cloudfront.net"
    }
    
    var url: URL?{
        return URL(string: "\(baseURL)\(path)")
    }
    
    
}
