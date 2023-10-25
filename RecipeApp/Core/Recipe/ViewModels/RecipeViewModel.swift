//
//  RecipeViewModel.swift
//  RecipeApp
//
//  Created by Shreya Singh on 10/24/23.
//

// RecipeViewModel.swift

import Foundation

class RecipeViewModel: ObservableObject {
    @Published var recipe: Recipe?
    var mealId: String?
    private let recipeDataService = RecipeDataService()

    init(mealID: String) {
        self.mealId = mealID
    }
    
    func fetchRecipeDetails() async {
        if let mealID = mealId {
            do {
                let recipe = try await recipeDataService.fetchRecipe(for: mealID)
                self.recipe = recipe
                print(self.recipe!.ingredients)
            } catch {
                print("Error fetching recipe details: \(error)")
            }
        }
    }
}
