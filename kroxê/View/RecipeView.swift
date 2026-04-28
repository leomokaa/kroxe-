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
                    Image("RecipeImageDefault").resizable()
                        .frame(maxWidth: .infinity)
                        .frame(height: 129)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                    
                    Text(recipe.name)
                        .font(.title.bold())
                    
                    HStack (spacing: 8){
                        HStack (spacing: 6){
                            Image(systemName: "wand.and.outline")
                            Text("Agulha: \(recipe.needle.formatted(.number.precision(.fractionLength(1)))) mm")
                        }
                        .font(.subheadline)
                        .padding(.vertical, 4)
                        .padding(.horizontal, 10)
                        .background(Color.lightLavanda, in: RoundedRectangle(cornerRadius: 10))
                        
                        if (!(recipe.yarn == 0)) {
                            HStack (spacing: 6){
                                Image(systemName: "circle")
                                if (!(recipe.yarn == 1)) { Text("\(recipe.yarn) Novelos")}
                                else { Text("\(recipe.yarn) Novelo")}
                            }
                            .font(.subheadline)
                            .padding(.vertical, 4)
                            .padding(.horizontal, 10)
                            .background(Color.lightLavanda, in: RoundedRectangle(cornerRadius: 10))
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
            }
            
            Spacer()
            
            
        }
        .padding(.horizontal)
        .backgroundCream()
    }
}

#Preview {
    RecipeView(recipe: Recipe(name: "Coelhinho", yarn: 2, needle: 3.5, text: "blabla"))
}
