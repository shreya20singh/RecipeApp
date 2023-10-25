//
//  RecipeView.swift
//  RecipeApp
//
//  Created by Shreya Singh on 10/24/23.
//

import SwiftUI

struct RecipeView: View {
    @ObservedObject var viewModel: RecipeViewModel
    
    init(viewModel: RecipeViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        ScrollView {
            VStack {
                if let recipe = viewModel.recipe {
                    Text(recipe.mealName)
                        .font(.title)
                        .fontWeight(.bold)
                        .padding()
                    
                    Text("Category: \(recipe.category ?? "")")
                        .font(.headline)
                        .padding()
                    
                    Text("Area: \(recipe.area ?? "")")
                        .font(.headline)
                        .padding()
                    
                    if let tags = recipe.tags {
                        Text("Tags: \(tags)")
                            .font(.headline)
                            .padding()
                    }
                    
                    Text("Instructions:")
                        .font(.headline)
                        .padding()
                    
                    Text(recipe.instructions)
                        .font(.body)
                        .padding()
                    
                    Text("Ingredients:")
                        .font(.headline)
                        .padding()
                    
                    if let ingredients = recipe.ingredients, let measurements = recipe.measurements {
                        ForEach(0..<min(ingredients.count, measurements.count), id: \.self) { index in
                            Text("\(ingredients[index]): \(measurements[index])")
                                .font(.body)
                                .padding()
                        }
                    }
                    
                    if let sourceURL = URL(string: recipe.sourceURL ?? ""), sourceURL.absoluteString != "" {
                        Link("Source", destination: sourceURL)
                            .font(.headline)
                            .padding()
                    }
                    
                    if let youtubeURL = URL(string: recipe.youtubeLink ?? ""), youtubeURL.absoluteString != "" {
                        Link("YouTube Video", destination: youtubeURL)
                            .font(.headline)
                            .padding()
                    }
                }
            }
        }
        .task {
            await viewModel.fetchRecipeDetails()
        }
    }
}


struct RecipeView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = RecipeViewModel(mealID: "52768")
        viewModel.mealId = "52768" // Provide a default mealID for the preview
        return RecipeView(viewModel: viewModel)
    }
}
