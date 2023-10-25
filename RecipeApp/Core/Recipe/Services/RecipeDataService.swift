//
//  RecipeDataService.swift
//  RecipeApp
//
//  Created by Shreya Singh on 10/24/23.
//

import Foundation

class RecipeDataService {
    private let cache = URLCache.shared
    
    func fetchRecipe(for mealID: String) async throws -> Recipe? {
        print(mealID)
        guard let url = URL(string: "https://themealdb.com/api/json/v1/1/lookup.php?i=\(mealID)") else {
            throw APIError.invalidURL
        }
        
        // Check if the response is available in the cache
        if let cachedResponse = cache.cachedResponse(for: URLRequest(url: url)) {
            do {
                let recipeResponse = try JSONDecoder().decode(RecipeResponse.self, from: cachedResponse.data)
                if let recipe = recipeResponse.meals.first {
                    return recipe
                }
            } catch {
                print("Error decoding cached response: \(error)")
            }
        }
        
        // If not in cache or cache has expired, proceed with the network request
        let (data, _) = try await URLSession.shared.data(from: url)
        
        do {
            let recipeResponse = try JSONDecoder().decode(RecipeResponse.self, from: data)
            if let recipe = recipeResponse.meals.first {
                // Cache the fetched data
                let dataToCache = try JSONEncoder().encode(recipeResponse)
                let cachedResponse = CachedURLResponse(response: URLResponse(url: url, mimeType: "application/json", expectedContentLength: dataToCache.count, textEncodingName: nil), data: dataToCache)
                cache.storeCachedResponse(cachedResponse, for: URLRequest(url: url))
                return recipe
            }
        } catch {
            print("Error decoding network response: \(error)")
            throw APIError.decodingError
        }
        
        return nil
    }
}

