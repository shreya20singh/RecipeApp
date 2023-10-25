//
//  Recipe.swift
//  RecipeApp
//
//  Created by Shreya Singh on 10/24/23.
//
import Foundation

struct Recipe: Codable {
    let mealName: String
    let instructions: String
    var ingredients: [String]?
    var measurements: [String]?
    let imageURL: URL?
    let category: String?
    let area: String?
    let tags: String?
    let youtubeLink: String?
    let sourceURL: String?
    let imageSource: String?
    let creativeCommonsConfirmed: String?
    let dateModified: String?

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        mealName = try container.decode(String.self, forKey: .mealName)
        instructions = try container.decode(String.self, forKey: .instructions)
        imageURL = try container.decodeIfPresent(URL.self, forKey: .imageURL)
        category = try container.decodeIfPresent(String.self, forKey: .category)
        area = try container.decodeIfPresent(String.self, forKey: .area)
        tags = try container.decodeIfPresent(String.self, forKey: .tags)
        youtubeLink = try container.decodeIfPresent(String.self, forKey: .youtubeLink)
        sourceURL = try container.decodeIfPresent(String.self, forKey: .sourceURL)
        imageSource = try container.decodeIfPresent(String.self, forKey: .imageSource)
        creativeCommonsConfirmed = try container.decodeIfPresent(String.self, forKey: .creativeCommonsConfirmed)
        dateModified = try container.decodeIfPresent(String.self, forKey: .dateModified)

        (ingredients, measurements) = Recipe.decodeIngredientsAndMeasurements(from: container)
    }

    enum CodingKeys: String, CodingKey {
        case mealName = "strMeal"
        case instructions = "strInstructions"
        case imageURL = "strMealThumb"
        case category = "strCategory"
        case area = "strArea"
        case tags = "strTags"
        case youtubeLink = "strYoutube"
        case sourceURL = "strSource"
        case imageSource = "strImageSource"
        case creativeCommonsConfirmed = "strCreativeCommonsConfirmed"
        case dateModified

        case strIngredient1, strIngredient2, strIngredient3, strIngredient4, strIngredient5, strIngredient6, strIngredient7, strIngredient8, strIngredient9, strIngredient10, strIngredient11, strIngredient12, strIngredient13, strIngredient14, strIngredient15, strIngredient16, strIngredient17, strIngredient18, strIngredient19, strIngredient20
        case strMeasure1, strMeasure2, strMeasure3, strMeasure4, strMeasure5, strMeasure6, strMeasure7, strMeasure8, strMeasure9, strMeasure10, strMeasure11, strMeasure12, strMeasure13, strMeasure14, strMeasure15, strMeasure16, strMeasure17, strMeasure18, strMeasure19, strMeasure20
    }

    static func decodeIngredientsAndMeasurements(from container: KeyedDecodingContainer<CodingKeys>) -> ([String]?, [String]?) {
        var ingredients: [String] = []
        var measurements: [String] = []
        for index in 1...20 {
            if let ingredientKey = CodingKeys(stringValue: "strIngredient\(index)"),
               let measurementKey = CodingKeys(stringValue: "strMeasure\(index)"),
               let ingredient = try? container.decodeIfPresent(String.self, forKey: ingredientKey),
               let measurement = try? container.decodeIfPresent(String.self, forKey: measurementKey) {
                if !ingredient.isEmpty {
                    ingredients.append(ingredient)
                }
                if !measurement.isEmpty {
                    measurements.append(measurement)
                }
            }
        }
        return (ingredients.isEmpty ? nil : ingredients, measurements.isEmpty ? nil : measurements)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(mealName, forKey: .mealName)
        try container.encode(instructions, forKey: .instructions)
        try container.encodeIfPresent(imageURL, forKey: .imageURL)
        try container.encodeIfPresent(category, forKey: .category)
        try container.encodeIfPresent(area, forKey: .area)
        try container.encodeIfPresent(tags, forKey: .tags)
        try container.encodeIfPresent(youtubeLink, forKey: .youtubeLink)
        try container.encodeIfPresent(sourceURL, forKey: .sourceURL)
        try container.encodeIfPresent(imageSource, forKey: .imageSource)
        try container.encodeIfPresent(creativeCommonsConfirmed, forKey: .creativeCommonsConfirmed)
        try container.encodeIfPresent(dateModified, forKey: .dateModified)

        // Encode ingredients and measurements up to 20
        for index in 1...20 {
            if let ingredient = ingredients?[safe: index - 1], !ingredient.isEmpty {
                try container.encode(ingredient, forKey: CodingKeys(stringValue: "strIngredient\(index)")!)
            }
            if let measurement = measurements?[safe: index - 1], !measurement.isEmpty {
                try container.encode(measurement, forKey: CodingKeys(stringValue: "strMeasure\(index)")!)
            }
        }
    }
}

extension Array {
    subscript(safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}

