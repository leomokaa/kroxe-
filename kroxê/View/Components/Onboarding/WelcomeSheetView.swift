//
//  WelcomeSheetView.swift
//  kroxê
//
//  Created by User on 04/05/26.
//

import SwiftUI

struct WelcomeSheetView: View {
    var body: some View {
        NavigationStack{
            VStack{
                VStack {
                    VStack (spacing: 16) {
                        Image("WelcomeImage")
                            .frame(maxWidth: .infinity)
                        VStack (spacing: 16){
                            Text("Boas Vindas ao Kroxê!")
                                .font(.largeTitle.bold())
                                .multilineTextAlignment(.center)
                            Text("Organize suas receitas de crochê em um só lugar!")
                                .multilineTextAlignment(.center)
                        }
                        .foregroundStyle(.ameixa)
                        .frame(width: 234)
                    }
                    Spacer()
                    
                    NavigationLink (destination: AboutRecipeView()) {
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
}

#Preview {
    WelcomeSheetView()
}
