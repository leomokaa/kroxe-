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
                    VStack (spacing: 38) {
                        Image("WelcomeImage")
                            .frame(maxWidth: .infinity)
                        VStack (spacing: 16){
                            Text("Boas Vindas ao Kroxê!")
                                .font(.largeTitle.bold())
                                .multilineTextAlignment(.center)
                                .frame(width: 200)
                            Text("Organize suas receitas de crochê em um só lugar!")
                                .multilineTextAlignment(.center)
                                .frame(width: 260)
                        }
                        .foregroundStyle(.ameixa)
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
                .navigationTitle("Kroxê")
                .navigationTitleColor(.creme)
                .navigationBarTitleDisplayMode(.inline)
                .frame(maxHeight: .infinity)
                .padding(.bottom, 28)
                
            }
            .backgroundCream()
        }
    }
}

#Preview {
    WelcomeSheetView()
}
