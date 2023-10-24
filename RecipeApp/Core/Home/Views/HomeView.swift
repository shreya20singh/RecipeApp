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
            ScrollView(showsIndicators: false) {
                LazyVStack {
                    ForEach($viewModel.meals) { $meal in
                        MealCellView(meal: meal)
                    }
                }
            }
            .padding()
            .refreshable {
                Task {
                    do {
                        await viewModel.fetchMeals()
                    } catch {
                        viewModel.isShowingErrorAlert = true
                        viewModel.errorAlertMessage = "Failed to refresh meals: \(error.localizedDescription)"
                    }
                }
            }
            .navigationTitle("Recipes")
            .navigationBarTitleDisplayMode(.inline)
        }
        .searchable(text: $viewModel.searchText, prompt: "Search")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    Task {
                        do {
                            await viewModel.fetchMeals()
                        } catch {
                            viewModel.isShowingErrorAlert = true
                            viewModel.errorAlertMessage = "Failed to fetch meals: \(error.localizedDescription)"
                        }
                    }
                } label: {
                    Image(systemName: "arrow.counterclockwise")
                        .foregroundColor(.black)
                }
            }
        }
        .alert(isPresented: $viewModel.isShowingErrorAlert) {
            Alert(
                title: Text("Error"),
                message: Text(viewModel.errorAlertMessage),
                dismissButton: .default(Text("OK"))
            )
        }
    }
}

#Preview {
    HomeView(viewModel: MealsViewModel(fetchService: FetchDessertDataService()))
}
