//
//  RecipeAppApp.swift
//  RecipeApp
//
//  Created by Shreya Singh on 10/23/23.
//

import SwiftUI

@main
struct RecipeAppApp: App {
    var body: some Scene {
        WindowGroup {
            let viewModel = MealsViewModel(fetchService: FetchDessertDataService())
            HomeView(viewModel: viewModel)
        }
    }
}
