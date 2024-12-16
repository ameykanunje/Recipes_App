//
//  MockAPIManager.swift
//  RecipesTests
//
//  Created by Amey Kanunje on 12/15/24.
//

import Foundation
import UIKit
@testable import Recipes


class MockAPIManager: APIManagerProtocol {
    var mockResult: Result<Recipes, Error>?
    var mockEndpoint: URL?
    
    func request<T: Decodable>(modelType: T.Type, type: any EndpointType) async throws -> T {
        if let mockResult = mockResult {
            switch mockResult {
            case .success(let recipes):
                if let recipes = recipes as? T {
                    return recipes
                } else {
                    throw NSError(domain: "TestError", code: 0, userInfo: [NSLocalizedDescriptionKey: "Unexpected type"])
                }
            case .failure(let error):
                throw error
            }
        } else if let url = mockEndpoint {
            let (data, _) = try await URLSession.shared.data(from: url)
            let decodedData = try JSONDecoder().decode(T.self, from: data)
            return decodedData
        } else {
            throw NSError(domain: "TestError", code: 0, userInfo: [NSLocalizedDescriptionKey: "No mock data or endpoint set"])
        }
    }
    
    func setMockResult(_ result: Result<Recipes, Error>) {
        self.mockResult = result
    }
}
