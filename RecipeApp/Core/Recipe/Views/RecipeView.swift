//
//  RecipeView.swift
//  RecipeApp
//
//  Created by Shreya Singh on 10/24/23.
//

import SwiftUI
import AVKit

struct RecipeView: View {
    @ObservedObject var viewModel: RecipeViewModel
    @State private var showFullInstructions = false
    
    init(viewModel: RecipeViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 10) {
                MealImageView(url: viewModel.recipe?.imageURL?.absoluteString ?? "")
                
                CenteredTitleView(title: viewModel.recipe?.mealName ?? "", font: .title, fontWeight: .bold)
                
                HStack {
                   Text("Area: \(viewModel.recipe?.area ?? "")")
                    Spacer()
                   if let sourceURLString = viewModel.recipe?.sourceURL, !sourceURLString.isEmpty,
                      let sourceURL = URL(string: sourceURLString) {
                       Link("Source", destination: sourceURL)
                   }
                    Spacer()
                    Text("Category: \(viewModel.recipe?.category ?? "")")
               }
               .font(.subheadline)
                
                HStack {
                    
                    if let tags = viewModel.recipe?.tags, !tags.isEmpty {
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack {
                                ForEach(tags.components(separatedBy: ","), id: \.self) { tag in
                                    Text(tag.trimmingCharacters(in: .whitespacesAndNewlines))
                                        .padding(5)
                                        .background(Color.gray.opacity(0.5))
                                        .cornerRadius(10)
                                }
                            }
                        }
                    }
                }
                .font(.subheadline)
                
                if let youtubeURL = URL(string: viewModel.recipe?.youtubeLink ?? ""), youtubeURL.absoluteString != "" {
                    YouTubeView(videoURL: youtubeURL)
                        .frame(height: 300)
                        .cornerRadius(3.0)
                }
                
                CenteredTitleView(title: "Instructions:", font: .headline, fontWeight: .semibold)
                    if let instructions = viewModel.recipe?.instructions {
                        Text(showFullInstructions ? instructions : String(instructions.prefix(200)) + "...")
                            .font(.body)
                    }
                if let instructions = viewModel.recipe?.instructions, instructions.count > 200 {
                    Button(action: {
                        showFullInstructions.toggle()
                    }) {
                        Text(showFullInstructions ? "Read Less" : "Read More")
                            .font(.subheadline)
                            .foregroundColor(.blue)
                    }
                }

                
                CenteredTitleView(title: "Ingredients:", font: .headline, fontWeight: .semibold)
                if let ingredients = viewModel.recipe?.ingredients, let measurements = viewModel.recipe?.measurements {
                    ForEach(0..<min(ingredients.count, measurements.count), id: \.self) { index in
                        Text("\(ingredients[index]): \(measurements[index])")
                            .font(.body)
                    }
                }
            }
            .padding()
        }
        .task {
            await viewModel.fetchRecipeDetails()
        }
    }
}


struct RecipeView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = RecipeViewModel(mealID: "52768")
        viewModel.mealId = "52768"
        return RecipeView(viewModel: viewModel)
    }
}
