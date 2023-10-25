//
//  RecipeResponseModel.swift
//  RecipeApp
//
//  Created by Shreya Singh on 10/24/23.
//

import Foundation

struct RecipeResponse: Codable {
    let meals: [Recipe]

    private enum CodingKeys: String, CodingKey {
        case meals
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        meals = try container.decode([Recipe].self, forKey: .meals)
    }
}
