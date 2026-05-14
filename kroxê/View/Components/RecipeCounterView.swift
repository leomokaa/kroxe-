//
//  RecipeCounterView.swift
//  kroxê
//
//  Created by User on 30/04/26.
//

import SwiftUI

struct RecipeCounterView: View {
    var recipe: Recipe
    
    var body: some View {
        VStack (spacing: 6) {
            HStack {
                Text ("Carreiras")
                    .font(.title3.bold())
                    .foregroundStyle(.ameixa)
                
                Spacer()
                
                Button ("", systemImage: "arrow.counterclockwise") {
                    recipe.counter = 0
                }
                .font(.title3)
            }
            
            HStack(spacing: 0) {
                Button {
                    if recipe.counter > 0 {
                        recipe.counter -= 1
                    }
                }
                label: {
                    Image(systemName: "minus")
                        .frame(height: 70)
                }
                .disabled(recipe.counter == 0)
                .buttonStyle(.borderedProminent)
                .buttonBorderShape(.circle)
                .tint(.rosaSuave)
                .font(.title)
                .fontWeight(.medium)
                
                Text("\(recipe.counter)")
                    .font(.largeTitle)
                    .fontWeight(.medium)
                    .foregroundStyle(.ameixa)
                    .frame(maxWidth: 100)
                
                Button {
                    recipe.counter += 1
                }
                label: {
                    Image(systemName: "plus")
                        .frame(height: 70)
                }
                .buttonStyle(.borderedProminent)
                .buttonBorderShape(.circle)
                .tint(.rosaSuave)
                .font(.title)
                .fontWeight(.medium)
            }
        }
        .frame(maxWidth: .infinity)
        .padding(.horizontal, 10)
        .padding(.top, 18)
        .padding(.bottom, 12)
        .glassEffect(.regular, in: RoundedRectangle(cornerRadius: 20))
//        glassView.cornerConfiguration = uniformTopRadius(0)
        .padding(.horizontal, 33)
        .padding(.bottom, 10)
        .preferredColorScheme(.light)
    }
}

#Preview {
    RecipeCounterView(recipe: Recipe(
        name: "Coelhinho",
        link: "link.com",
        yarn: 1,
        needle: 0.1,
        text: """
        #titulo
        Rnd 1. 7 sc in Magic Ring (7)
        Rnd 2. 7 inc (14)
        Rnd 3. (1 single crochet, inc) x 7 (21)
        Rnd 4. (2 sc, inc) x 7 (28)
        Rnd 5. (3 sc, inc) x 7 (35)
        Rnd 6 - 13. sc in each (35)
        Add safety eyes between rounds 10 and 11, 7 st apart
        Stuff
        
        #titulo 2
        Rnd 14. (3 sc, dec) x 7 (28)
        Rnd 15. (2 sc, dec) x 7 (21)
        Rnd 16. (1 sc, dec) x 7 (14)
        Stuff some more
        Rnd 17. 14 dec (7)
        sl st and f.o.
        Embroider a nose between rounds 10 and 11, mouth from 11  to 12
        """,
        counter: 0, isFirstRecipe: false
    )
)
}
