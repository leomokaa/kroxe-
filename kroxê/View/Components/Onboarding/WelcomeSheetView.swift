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
            VStack {
                Image("WelcomeImage")
                    .resizable()
                    .scaledToFill()
                    .frame(maxWidth: .infinity, maxHeight: 300, alignment: .bottom)
                    .accessibilityHidden(true)
                Spacer()
                VStack (spacing: 10){
                    Text("Boas Vindas ao Kroxê!")
                        .font(.largeTitle.bold())
                        .multilineTextAlignment(.center)
                        .lineLimit(nil)
                    Text("Organize suas receitas de crochê em um só lugar!")
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                }
                .frame(maxWidth: 300)
                .foregroundStyle(.ameixa)
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
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Kroxê")
                        .foregroundStyle(.cremeHidden)
                        .accessibilityHidden(true)
                }
            }
            .frame(maxHeight: .infinity)
            .padding(.bottom, 28)
            .backgroundCream()
        }
    }
}

#Preview {
    VStack {
        
    }
    .sheet(isPresented: .constant(true)) {
        WelcomeSheetView()
    }
}
