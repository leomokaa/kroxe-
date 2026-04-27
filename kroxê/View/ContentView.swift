//
//  PageView.swift
//  kroxê
//
//  Created by User on 17/04/26.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Query private var recipes: [Recipe] = [
        Recipe(name: "coelho", link: "lalala", yarn: 12, needle: 2.0, text: "lalala"),
        Recipe(name: "blusa", link: "blablbla", yarn: 7, needle: 4.1, text: "fafafa"),
        Recipe(name: "dinossauro", link: "gegege", yarn: 5, needle: 3.4, text: "lilili")
    ]
    
    var body: some View {
        NavigationStack {
            VStack {}
            }
            .navigationTitle("Minhas Receitas")
        
    }
}




#Preview {
        ContentView ()
}
