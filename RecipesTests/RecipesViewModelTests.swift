//
//  RecipesViewModelTests.swift
//  RecipesTests
//
//  Created by Amey Kanunje on 12/15/24.
//

import XCTest
@testable import Recipes

@MainActor
final class RecipesViewModelTests: XCTestCase {
    
    var vm: RecipesViewModel!
    var mockAPIManager: MockAPIManager!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        mockAPIManager = MockAPIManager()
        vm = RecipesViewModel(apiManager: mockAPIManager)
    }
    
    override func tearDownWithError() throws {
        vm = nil
        mockAPIManager = nil
        try super.tearDownWithError()
    }
    
    func test_FetchRecipeData_onSuccess() async throws{
        //Given
        mockAPIManager.mockEndpoint = URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/recipes.json")
        
        //When
        await vm.fetchRecipeData()
        
        //Then
        XCTAssertFalse(vm.isLoading)
        XCTAssertFalse(vm.recipe.isEmpty)
        XCTAssertNil(vm.errorMessage)
    }
    
    func test_FetchRecipeData_onFailure() async throws{
        //Given
        mockAPIManager.mockEndpoint = URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/recipes-malformed.json")
        
        //When
        await vm.fetchRecipeData()
        
        //then - should not be parsed, recipe is empty, errorMessage- something, isLoading true,
        XCTAssertFalse(vm.isLoading)
        XCTAssertNotNil(vm.errorMessage)
        XCTAssertEqual(vm.errorMessage, "No recipes available")
        XCTAssertTrue(vm.recipe.isEmpty)
    }
    
    func test_FetchRecipeData_isEmpty() async throws {
        //Given
        mockAPIManager.mockEndpoint = URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/recipes-empty.json")
        
        //When
        await vm.fetchRecipeData()
        
        //Then
        XCTAssertFalse(vm.isLoading)
        XCTAssertNil(vm.errorMessage)
        XCTAssertTrue(vm.recipe.isEmpty)
    }
    
    func test_GetImage_FromCache() async throws {
        // Given
        let url = URL(string: "https://example.com/image.jpg")!
        let mockImage = UIImage(systemName: "star")!
        await vm.imageCache.setImage(for: url, mockImage)
        
        // When
        let resultImage = await vm.getImage(for: url)
        
        // Then
        XCTAssertNotNil(resultImage)
        XCTAssertEqual(resultImage?.pngData(), mockImage.pngData())
    }
    
    
    func test_ClearImage_FromCache() async throws {
        // Given
        let url = URL(string: "https://example.com/image.jpg")!
        let mockImage = UIImage(systemName: "star")!
        await vm.imageCache.setImage(for: url, mockImage) // This will cache the mock image
        
        // When
        vm.cleanData()
        
        // Then
        let cachedImage = await vm.imageCache.isCacheEmpty()
        XCTAssertFalse(cachedImage, "Cache Should Be Empty After Cleaning the cache")
    }
}
