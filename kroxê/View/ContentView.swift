//
//  PageView.swift
//  kroxê
//
//  Created by User on 17/04/26.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    
    @State var searchQuery: String = ""
    
    var body: some View {
        TabView {
            Tab("Receitas", systemImage: "book") {
                RecipesListView()
            }
            Tab("Guia", systemImage: "graduationcap") {
                GuideView()
            }
        }
    }
}
//            SearchScreen()
//                            .background(Color("BackgroundColor"))
//                            .tabItem{
//                                Image(systemName: "magnifyingglass")
//                            }
//        }.searchable(
//            text: $searchQuery,
//            placement: .toolbar,
//            prompt: "Pesquise Receitas"
//        )
//        .searchToolbarBehavior(.minimize)
//    }


#Preview {
    return ContentView()
        .modelContainer(PreviewSetup.previewRecepiesList)
}
