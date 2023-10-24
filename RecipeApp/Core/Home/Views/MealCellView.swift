//
//  MealCellView.swift
//  RecipeApp
//
//  Created by Shreya Singh on 10/23/23.
//

import SwiftUI

struct MealCellView: View {
    let meal: Meal
    var body: some View {
        VStack {
            MealImageView(meal: meal)
                .background(Color.gray.opacity(0.3))
                .cornerRadius(10)

            Text(meal.name)
                .font(.headline)
                .fontWeight(.bold)
                .padding(.vertical, 8)
                .padding(.horizontal, 16)
                .background(.gray)
                .foregroundColor(.white)
                .cornerRadius(10)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 5) 
    }
}

#Preview {
    MealCellView(meal:Meal(name: "1", image: "https://www.themealdb.com/images/media/meals/adxcbq1619787919.jpg", id: "sample-image-url"))
}
