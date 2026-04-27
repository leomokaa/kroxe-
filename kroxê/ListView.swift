//
//  ListView.swift
//  kroxê
//
//  Created by User on 24/04/26.
//


import SwiftUI
import SwiftData

struct ListView: View {
    @Query private var receitasList: [recipe]
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 20) {
                    
                    HStack {
                        Text("Minhas Receitas")
                            .font(.largeTitle.bold())
                        Spacer()
                    }
                }
            }
        }
    }
}
    
    #Preview {
        ListView()
    }
