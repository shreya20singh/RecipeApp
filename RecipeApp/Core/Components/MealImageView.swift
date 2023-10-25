//
//  MealImageView.swift
//  RecipeApp
//
//  Created by Shreya Singh on 10/23/23.
//

import SwiftUI
import Kingfisher

struct MealImageView: View {
    let url: String?

    var body: some View {
        KFImage(URL(string: url ?? "fork.knife.circle.fill"))
            .placeholder {
                ProgressView()
            }
            .resizable()
            .scaledToFit()
            .clipShape(Rectangle())
            .cornerRadius(7)
            .opacity(0.9)
    }
}



#Preview {
    MealImageView(url: "https://www.themealdb.com/images/media/meals/adxcbq1619787919.jpg")
}
