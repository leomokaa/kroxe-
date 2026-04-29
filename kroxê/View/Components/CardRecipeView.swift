//
//  CardRecipeView.swift
//  kroxê
//
//  Created by User on 27/04/26.
//

import SwiftUI

struct CardRecipeView: View {
    var recipe: Recipe
    
    var body: some View {
        NavigationLink (destination: RecipeView(recipe: recipe)) {
            VStack (alignment: .leading, spacing: 12) {
                if let data = recipe.photo {
                    if let uiImage = UIImage(data: data) {
                        HStack(alignment: .center){
                            Image(uiImage: uiImage).resizable()
                                .frame(maxWidth: .infinity)
                                .frame(height: 129)
                                .clipShape(RoundedRectangle(cornerRadius: 6))
                        }
                        .frame(maxWidth: .infinity)
                    }
                } else {
                    HStack(alignment: .center) {
                        Image("RecipeImageDefault").resizable()
                            .frame(maxWidth: .infinity)
                            .frame(height: 129)
                            .clipShape(RoundedRectangle(cornerRadius: 6))
                    }
                    .frame(maxWidth: .infinity)
                }
                
                VStack (alignment: .leading, spacing: 8) {
                    Text(recipe.name)
                        .font(.title2.bold())
                    
                    HStack (spacing: 8){
                        if (!(recipe.needle == 0)) {
                            TagCardView(tagIcon: "wand.and.outline", tagName: "Agulha: \(recipe.needle.formatted(.number.precision(.fractionLength(1)))) mm")
                        }
                        
                        if (!(recipe.yarn == 0)) {
                            if (!(recipe.yarn == 1)) {
                                TagCardView(tagIcon: "circle", tagName: "\(recipe.yarn) Novelos")
                            }
                            else {
                                TagCardView(tagIcon: "circle", tagName: "\(recipe.yarn) Novelo")
                            }
                        }
                    }
                }
                .padding(.horizontal, 4)
            }
            .foregroundStyle(.ameixa)
            .padding(.horizontal, 10)
            .padding(.top, 10)
            .padding(.bottom, 15)
            .background(Color.cremeBranco, in: RoundedRectangle(cornerRadius: 15))
        }
    }
        
}

#Preview {
    CardRecipeView(recipe: Recipe(name: "Coelhinho", yarn: 2, needle: 3.5, text: "blabla"))
}
