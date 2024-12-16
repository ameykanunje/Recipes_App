//
//  APIManagerTests.swift
//  RecipesTests
//
//  Created by Amey Kanunje on 12/15/24.
//

import XCTest
@testable import Recipes


final class APIManagerTests: XCTestCase {
    
    var api: APIManager!
    
    override func setUp() {
        super.setUp()
        api = APIManager(session: .shared)
    }
    
    override func tearDown() {
        api = nil
        super.tearDown()
    }
    
    func test_RequestSuccess() async throws {
        // When
        let result: Recipes = try await api.request(modelType: Recipes.self, type: EndpointItems.Recipes)
        
        // Then
        XCTAssertFalse(result.recipes.isEmpty, "Recipes should not be empty")
        
        // Test the first recipe
        if let firstRecipe = result.recipes.first {
            XCTAssertFalse(firstRecipe.name.isEmpty, "Recipe name should not be empty")
            XCTAssertFalse(firstRecipe.cuisine.isEmpty, "Recipe cuisine should not be empty")
            XCTAssertFalse(firstRecipe.uuid.isEmpty, "Recipe UUID should not be empty")
            XCTAssertFalse(firstRecipe.photoURLSmall.isEmpty, "Recipe small photo URL should not be empty")
            XCTAssertFalse(firstRecipe.photoURLLarge.isEmpty, "Recipe large photo URL should not be empty")
        } else {
            XCTFail("No recipes returned")
        }
    }
    
    func test_RequestInvalidURL() async {
        // Given
        struct InvalidEndpoint: EndpointType {
            var path: String { return "/invalid" }
            var baseURL: String { return "https://invalid.example.com" }
            var url: URL? { return URL(string: baseURL + path) }
        }
        
        // When/Then
        do {
            let _: Recipes = try await api.request(modelType: Recipes.self, type: InvalidEndpoint())
            XCTFail("Expected error, but request succeeded")
        } catch {
            XCTAssertTrue(error is DataError, "Error should be of type DataError")
        }
    }
    
    func test_RecipeComputedProperties() async throws {
        // Given
        let recipes: Recipes = try await api.request(modelType: Recipes.self, type: EndpointItems.Recipes)
        guard let recipe = recipes.recipes.first else {
            XCTFail("No recipes returned")
            return
        }
        
        // Then
        XCTAssertNotNil(recipe.photoURLSmallConverted, "Small photo URL should be convertible to URL")
        XCTAssertEqual(recipe.photoURLSmallConverted, URL(string: recipe.photoURLSmall))
        
        if let youtubeURL = recipe.youtubeURL {
            XCTAssertNotNil(recipe.youtubeURLConverted, "YouTube URL should be convertible to URL")
            XCTAssertEqual(recipe.youtubeURLConverted, URL(string: youtubeURL))
        }
        
        if let sourceURL = recipe.sourceURL {
            XCTAssertNotNil(recipe.sourceURLConverted, "Source URL should be convertible to URL")
            XCTAssertEqual(recipe.sourceURLConverted, URL(string: sourceURL))
        }
    }
    
}
