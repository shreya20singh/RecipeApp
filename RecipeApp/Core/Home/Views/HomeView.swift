//
//  HomeView.swift
//  RecipeApp
//
//  Created by Shreya Singh on 10/23/23.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var viewModel: MealsViewModel
    @State var selectedMealID: String?

    var body: some View {
        NavigationView {
            ScrollView {
                LazyVStack {
                    ForEach(viewModel.searchText.isEmpty ? viewModel.meals : viewModel.filteredMeals) { meal in
                        NavigationLink(
                            destination: RecipeView(viewModel: RecipeViewModel(mealID: meal.id)), // Pass the mealID
                            tag: meal.id,
                            selection: $selectedMealID
                        ) {
                            MealCellView(meal: meal)
                        }
                        .onTapGesture {
                            selectedMealID = meal.id
                        }
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
            .searchable(text: $viewModel.searchText, placement: .navigationBarDrawer(displayMode: .always), prompt: "Search")
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
    HomeView(viewModel: MealsViewModel(fetchService: FetchDessertDataService()), selectedMealID: "")
}
