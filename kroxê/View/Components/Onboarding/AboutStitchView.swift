//
//  AboutStitchView.swift
//  kroxê
//
//  Created by User on 05/05/26.
//

import SwiftUI

struct AboutStitchView: View {
    @Environment(\.dismiss) private var dismiss
    
    @AppStorage("isFirstLaunch") var isFirstLaunch = true
    
    var body: some View {
        VStack{
            VStack {
                VStack (spacing: 52) {
                    Image("StitchCardsImage")
                        .frame(maxWidth: .infinity)
                    VStack (spacing: 16){
                        Text("Sem complicação")
                            .font(.title.bold())
                            .multilineTextAlignment(.center)
                        Text("Seus pontos ficam no topo da receita. Quando precisar, é só consultar o guia para relembrar quais são.")
                            .multilineTextAlignment(.center)
                    }
                    .frame(width: 312)
                    .foregroundStyle(.ameixa)
                }
                Spacer()
                
                Button {
                    isFirstLaunch = false
                } label: {
                    Text("Começar")
                        .padding(.vertical, 14)
                        .fontWeight(.medium)
                        .foregroundStyle(.creme)
                        .frame(width: 280)
                        .background(Color.accent, in: RoundedRectangle(cornerRadius: 296))
                }
            }
            .frame(maxHeight: .infinity)
            .padding(.bottom, 28)
            
        }
        .backgroundCream()
    }
}

#Preview {
    AboutStitchView()
}
