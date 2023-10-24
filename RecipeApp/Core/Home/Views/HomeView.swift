//
//  HomeView.swift
//  RecipeApp
//
//  Created by Shreya Singh on 10/23/23.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var viewModel: MealsViewModel

    var body: some View {
        NavigationView {
            ScrollView {
                LazyVStack {
                    ForEach(viewModel.searchText.isEmpty ? viewModel.meals : viewModel.filteredMeals) { meal in
                        MealCellView(meal: meal)
                    }
                }
            }
            .padding()
            .refreshable {
                Task {
                    viewModel.fetchMeals()
                }
            }
            .navigationTitle("Recipes")
            .navigationBarTitleDisplayMode(.inline)
            .searchable(text: $viewModel.searchText, prompt: "Search")
        }
        .alert(isPresented: $viewModel.isShowingErrorAlert) {
            Alert(
                title: Text("Error"),
                message: Text(viewModel.errorAlertMessage),
                dismissButton: .default(Text("OK"))
            )
        }
        .onChange(of: viewModel.searchText) {
                    viewModel.filterMeals()
        }
    }
}

#Preview {
    HomeView(viewModel: MealsViewModel(fetchService: FetchDessertDataService()))
}
