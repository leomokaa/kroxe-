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
                    .frame(maxWidth: .infinity, maxHeight: 400, alignment: .bottom)
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
            .navigationTitle("Kroxê")
            .navigationTitleColor(.creme)
            .navigationBarTitleDisplayMode(.inline)
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
