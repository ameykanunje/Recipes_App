//
//  RecipeRowView.swift
//  Recipes
//
//  Created by Amey Kanunje on 12/15/24.
//

import SwiftUI

struct RecipeRowView: View {
    let recipe: Recipe
    let getImage: (URL) async -> UIImage?
    let openURL: OpenURLAction
    @State private var image: UIImage?
    @State private var isVisible = false
    
    
    var body: some View {
        HStack{
            if isVisible{
                if let image = image{
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 80, height: 80)
                        .cornerRadius(8)
                }
            } else {
                Color.gray.opacity(0.3)
                    .frame(width: 80, height: 80)
                    .cornerRadius(8)
            }
            
            VStack(alignment: .leading) {
                Text(recipe.cuisine)
                    .font(.caption)
                    .foregroundStyle(.secondary)
                
                Text(recipe.name)
                
                HStack(){
                    if let youTubeURL = recipe.youtubeURLConverted {
                        Button(action: {
                            openURL(youTubeURL)
                        }) {
                            Text("YouTube")
                                .font(.caption)
                                .foregroundColor(.blue)
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                    if let sourceURL = recipe.sourceURLConverted {
                        Button(action: {
                            openURL(sourceURL)
                        }) {
                            Text("More Info")
                                .font(.caption)
                                .foregroundColor(.blue)
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                    
                }
            }
            .task {
                if let url = recipe.photoURLSmallConverted {
                    image = await getImage(url)
                }
            }
        }
        .padding(.vertical, 8)
        .background(Color.clear)
        .onAppear { isVisible = true }
        .onDisappear { isVisible = false }
    }
}
