//
//  RecipesView.swift
//  Recipes
//
//  Created by Amey Kanunje on 12/15/24.
//

import SwiftUI


struct RecipesView: View {
    @StateObject var vm = RecipesViewModel()
    @Environment(\.openURL) var openURL
    @Environment(\.scenePhase) var scenePhase
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVStack(alignment: .leading, spacing: 10) {
                    ForEach(vm.recipe, id: \.self) { recipe in
                        RecipeRowView(recipe: recipe, getImage: vm.getImage, openURL: openURL)
                            .padding(.horizontal)
                    }
                }
            }
            .navigationTitle("Recipes")
            .refreshable {
                vm.cleanData()
                //print("Manual refresh triggered")
                await vm.fetchRecipeData()
            }
            if vm.isLoading {
                ProgressView()
            }
        }
        .task {
            print("View appeared, fetching data")
            await vm.fetchRecipeData()
        }
        .onChange(of: scenePhase) { newPhase in
            switch newPhase {
            case .active:
                Task {
                    //print("App became active, fetching fresh data")
                    await vm.fetchRecipeData()
                }
            case .inactive:
                print("App became inactive")
            case .background:
                //print("App entered background, clearing image cache")
                vm.cleanData()
            @unknown default:
                break
            }
        }
    }
}


#Preview {
    RecipesView()
}
