//
//  RecipesViewModel.swift
//  Recipes
//
//  Created by Amey Kanunje on 12/15/24.
//

import Foundation
import UIKit

@MainActor
class RecipesViewModel: ObservableObject {
    @Published var recipe: [Recipe] = []
    @Published var isLoading = false
    @Published var errorMessage: String?
    @Published var state: FetchDataError = .empty
    
    private let apiManager: APIManagerProtocol
    let imageCache = ImageCache()
    
    init(apiManager: APIManagerProtocol = APIManager()) {
        self.apiManager = apiManager
        print("RecipesViewModel Initialized")
    }
    
    func fetchRecipeData() async {
        print("fetchRecipeData called")
        isLoading = true
        errorMessage = nil
        
        do {
            let recipeData = try await apiManager.request(modelType: Recipes.self, type: EndpointItems.Recipes)
            self.recipe = recipeData.recipes
            self.errorMessage = nil
        } catch {
            self.recipe = []
            self.errorMessage = "No recipes available"
        }
        
        isLoading = false
    }
    
    func getImage(for url: URL) async -> UIImage? {
        if let cacheImage = await imageCache.getImage(for: url) {
            return cacheImage
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            guard let image = UIImage(data: data) else {
                return nil
            }
            
            await imageCache.setImage(for: url, image)
            print("Image Added to Cache")
            return image
            
        } catch{
            print("Failed to cache Image")
        }
        
        return nil
    }
    
    func cleanData() {
        recipe.removeAll()
        Task{
            await imageCache.clearCache()
            print("Data and Cache Image Cleared")
        }
        
    }
}


enum FetchDataError{
    case loading
    case loaded
    case error(String)
    case empty
}
