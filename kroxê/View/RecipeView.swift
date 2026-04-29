//
//  RecipeView.swift
//  kroxê
//
//  Created by User on 28/04/26.
//

import SwiftUI

struct RecipeView: View {
    var recipe: Recipe
    
    var body: some View {
        VStack{
            VStack(alignment: .leading, spacing: 20){
                VStack(alignment: .leading, spacing: 12){
                    if let data = recipe.photo {
                        if let uiImage = UIImage(data: data) {
                            HStack(alignment: .center){
                                Image(uiImage: uiImage)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 370, height: 148)
                                    .clipShape(RoundedRectangle(cornerRadius: 10))
                            }
                            .frame(maxWidth: .infinity)
                        }
                    } else {
                        HStack(alignment: .center) {
                            Image("RecipeImageDefault")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 370, height: 148)
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                        }
                        .frame(maxWidth: .infinity)
                    }
                    
                    Text(recipe.name)
                        .font(.title.bold())
                        .foregroundStyle(.ameixa)
                    
                    HStack (spacing: 8){
                        if (!(recipe.needle == 0)) {
                            TagRecipeView(tagIcon: "wand.and.outline", tagName: "Agulha: \(recipe.needle.formatted(.number.precision(.fractionLength(1)))) mm")
                        }
                        
                        if (!(recipe.yarn == 0)) {
                            if (!(recipe.yarn == 1)) {
                                TagRecipeView(tagIcon: "circle", tagName: "\(recipe.yarn) Novelos")
                            }
                            else {
                                TagRecipeView(tagIcon: "circle", tagName: "\(recipe.yarn) Novelo")
                            }
                        }
                    }
                }
                ScrollView(.horizontal, showsIndicators: false){
                    HStack(alignment: .top){
                        CardRecipeStitchView(stitch: Stitch.chain)
                        CardRecipeStitchView(stitch: Stitch.doubleTrebleCrochet)
                        CardRecipeStitchView(stitch: Stitch.halfDoubleCrochet)
                        CardRecipeStitchView(stitch: Stitch.magicRing)
                        CardRecipeStitchView(stitch: Stitch.slipStitch)
                        
                    }
                }
                Text(recipe.text)
                    .foregroundStyle(.ameixa)
            }
            
            Spacer()
            
            
        }
        .padding(.top, 10)
        .padding(.horizontal)
        .backgroundCream()
    }
}

#Preview {
    RecipeView(recipe: Recipe(name: "Coelhinho", yarn: 2, needle: 3.5, text: "blabla"))
}
