//
//  AboutRecipeView.swift
//  kroxê
//
//  Created by User on 04/05/26.
//

import SwiftUI

struct AboutRecipeView: View {
    var body: some View {
        VStack{
            VStack {
                VStack (spacing: 32) {
                    Image("RecipeImage")
                        .frame(maxWidth: .infinity)
                    VStack (spacing: 16){
                        Text("Sua receita, do seu jeito")
                            .font(.largeTitle.bold())
                            .multilineTextAlignment(.center)
                        Text("Escreva livremente, separe por etapas e acompanhe cada carreira sem se perder enquanto faz.")
                            .multilineTextAlignment(.center)
                    }
                    .foregroundStyle(.ameixa)
                    .frame(width: 234)
                }
                Spacer()
                
                NavigationLink (destination: CreateRecipeView()) {
                    Text("Próximo")
                        .padding(.vertical, 14)
                        .fontWeight(.medium)
                        .foregroundStyle(.creme)
                        .frame(width: 280)
                        .background(Color.accent, in: RoundedRectangle(cornerRadius: 296))
                }
            }
            .frame(maxHeight: .infinity)
            .padding(.bottom, 32)
            
        }
        .backgroundCream()
    }
}

#Preview {
    AboutRecipeView()
}
