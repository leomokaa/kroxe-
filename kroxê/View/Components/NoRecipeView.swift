//
//  NoRecipeView.swift
//  kroxê
//
//  Created by User on 30/04/26.
//

import SwiftUI

struct NoRecipeView: View {
    var body: some View {
        VStack{
            VStack(spacing: 12){
                Image("NoRecipeIllustra")
                VStack(spacing: 4){
                    Text("Você não tem receitas")
                        .font(.headline)
                        .foregroundStyle(.ameixa.opacity(0.6))
                    Text("Clique no + para criar uma nova receita")
                        .font(.footnote)
                        .foregroundStyle(.ameixa.opacity(0.6))
                }
            }
            .padding(.bottom, 32)
        }
        .frame(maxWidth: .infinity)
    }
}
    

#Preview {
    NoRecipeView()
}
