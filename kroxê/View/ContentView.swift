//
//  PageView.swift
//  kroxê
//
//  Created by User on 17/04/26.
//

import SwiftUI
import SwiftData

struct ContentView: View {
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

#Preview {
    return ContentView()
        .modelContainer(PreviewSetup.previewRecepiesList)
}
