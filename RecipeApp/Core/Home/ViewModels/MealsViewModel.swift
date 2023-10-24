//
//  MealsViewModel.swift
//  RecipeApp
//
//  Created by Shreya Singh on 10/23/23.
//

import Foundation

class MealsViewModel: ObservableObject {
    @Published var meals: [Meal] = []
    @Published var filteredMeals: [Meal] = []
    @Published var isShowingErrorAlert = false
    @Published var errorAlertMessage = ""
    @Published var searchText = ""

    private let fetchService: FetchDessertDataService

    init(fetchService: FetchDessertDataService) {
        self.fetchService = fetchService
        fetchMeals()
    }

    func fetchMeals() {
        Task {
            do {
                let meals = try await fetchService.fetchData()
                print("Fetched \(meals.count) meals")
                DispatchQueue.main.async {
                    self.meals = meals
                }
            } catch {
                DispatchQueue.main.async {
                    self.isShowingErrorAlert = true
                    self.errorAlertMessage = "Failed to fetch meals: \(error.localizedDescription)"
                    print("Failed to fetch meals: \(error)")
                }
            }
        }
    }

    func filterMeals() {
        if searchText.isEmpty {
            filteredMeals = meals
        } else {
            filteredMeals = meals.filter { meal in
                return meal.name.lowercased().contains(searchText.lowercased())
            }
        }
    }

}

