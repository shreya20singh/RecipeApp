//
//  FetchDessertDataService.swift
//  RecipeApp
//
//  Created by Shreya Singh on 10/23/23.
//

import Foundation

class FetchDessertDataService {
    private let cache = URLCache.shared
    var url = "https://themealdb.com/api/json/v1/1/filter.php?c=Dessert"
    
    func fetchData() async throws -> [Meal] {
        guard let url = URL(string: url) else {
            throw APIError.invalidURL
        }
        
        // Check if the response is available in the cache
        if let cachedResponse = cache.cachedResponse(for: URLRequest(url: url)) {
            if let mealResponse = try? JSONDecoder().decode(MealResponse.self, from: cachedResponse.data) {
                return mealResponse.meals
            }
        }
        
        // If not in cache or cache has expired, proceed with the network request
        let (data, _) = try await URLSession.shared.data(from: url)
        
        guard let mealResponse = try? JSONDecoder().decode(MealResponse.self, from: data) else {
            throw APIError.decodingError
        }
        
        // Cache the fetched data
        let dataToCache = try JSONEncoder().encode(mealResponse)
        let cachedResponse = CachedURLResponse(response: URLResponse(url: url, mimeType: "application/json", expectedContentLength: dataToCache.count, textEncodingName: nil), data: dataToCache)
        cache.storeCachedResponse(cachedResponse, for: URLRequest(url: url))
        
        return mealResponse.meals
    }
}

