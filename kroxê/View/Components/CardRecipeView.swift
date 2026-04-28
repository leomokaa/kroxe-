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
                Image("RecipeImageDefault").resizable()
                    .frame(maxWidth: .infinity)
                    .frame(height: 129)
                    .clipShape(RoundedRectangle(cornerRadius: 6))
                
                VStack (alignment: .leading, spacing: 8) {
                    Text(recipe.name)
                        .font(.title2.bold())
                    
                    HStack (spacing: 8){
                        HStack (spacing: 4){
                            Image(systemName: "wand.and.outline")
                            Text("Agulha: \(recipe.needle.formatted(.number.precision(.fractionLength(1)))) mm")
                        }
                        .font(.footnote)
                        .padding(.vertical, 4)
                        .padding(.horizontal, 6)
                        .background(Color.lightLavanda, in: RoundedRectangle(cornerRadius: 4))
                        
                        if (!(recipe.yarn == 0)) {
                            HStack (spacing: 4){
                                Image(systemName: "circle")
                                if (!(recipe.yarn == 1)) { Text("\(recipe.yarn) Novelos")}
                                else { Text("\(recipe.yarn) Novelo")}
                            }
                            .font(.footnote)
                            .padding(.vertical, 4)
                            .padding(.horizontal, 6)
                            .background(Color.lightLavanda, in: RoundedRectangle(cornerRadius: 4))
                        }
                    }
                }
                .padding(.horizontal, 4)
            }
            .foregroundStyle(.ameixa)
            .padding(.horizontal, 10)
            .padding(.top, 10)
            .padding(.bottom, 15)
            .background(Color.white, in: RoundedRectangle(cornerRadius: 15))
        }
    }
        
}

#Preview {
    CardRecipeView(recipe: Recipe(name: "Coelhinho", yarn: 2, needle: 3.5, text: "blabla"))
}
