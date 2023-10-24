//
//  MealImageView.swift
//  RecipeApp
//
//  Created by Shreya Singh on 10/23/23.
//

import SwiftUI
import Kingfisher

struct MealImageView: View {
    let meal: Meal

    var body: some View {
        KFImage(URL(string: meal.image ?? "fork.knife.circle.fill"))
            .placeholder {
                ProgressView()
            }
            .resizable()
            .scaledToFit()
            .clipShape(Rectangle())
            .cornerRadius(7)
    }
}



#Preview {
    MealImageView(meal:Meal(name: "1", image: "https://www.themealdb.com/images/media/meals/adxcbq1619787919.jpg", id: "sample-image-url"))
}
