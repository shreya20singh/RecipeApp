//
//  CenteredTitleView.swift
//  RecipeApp
//
//  Created by Shreya Singh on 10/25/23.
//

import SwiftUI

struct CenteredTitleView: View {
    let title: String
    let font: Font
    let fontWeight: Font.Weight

    init(title: String, font: Font = .title, fontWeight: Font.Weight = .bold) {
        self.title = title
        self.font = font
        self.fontWeight = fontWeight
    }

    var body: some View {
        HStack {
            Spacer()
            Text(title)
                .font(font)
                .fontWeight(fontWeight)
            Spacer()
        }
        .padding()
    }
}


#Preview {
    CenteredTitleView(title: "Title", font: .subheadline, fontWeight: .semibold)
}
