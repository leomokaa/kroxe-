//
//  ListView.swift
//  kroxê
//
//  Created by User on 24/04/26.
//


import SwiftUI
import SwiftData

struct ListView: View {
    @Query private var receitasList: [Receita]
    var body: some View {
        NavigationStack {
            VStack {
                List{
                }
            }
        }
    }
}
#Preview {
    ListView()
}
