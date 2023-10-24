//
//  MealModel.swift
//  RecipeApp
//
//  Created by Shreya Singh on 10/23/23.
//

import Foundation

struct MealResponse: Codable {
    let meals: [Meal]
}

struct Meal: Codable, Identifiable {
    let name: String
    let image: String?
    let id: String

    enum CodingKeys: String, CodingKey {
        case name = "strMeal"
        case image = "strMealThumb"
        case id = "idMeal"
    }

    var thumbnail: String {
        // Use "fork.knife.circle.fill" as the default value if image is empty
        return image ?? "fork.knife.circle.fill"
    }
}

