//
//  Preview.swift
//  kroxê
//
//  Created by User on 27/04/26.
//

import SwiftData

enum PreviewSetup {
    static var previewRecepiesList: ModelContainer {
        let configuration = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try! ModelContainer(for: Recipe.self, configurations: configuration)
        let recipes: [Recipe] = [
//            Recipe(name: "Estrelinha", link: "", yarn: 1, needle: 0.0, text: "lalala", counter: 0),
            Recipe(name: "Minha Primeira Receita", link: "", yarn: 0, needle: 0.0, text: """
        #Receita
        Faça um nó inicial
        Carreira 1: 6 corr [10]
        Carreira 2: 6 pb [10]
        Carreira 3: 3 [sc, inc] [9]

        #Dicas
        Use # no início da linha para escrever um título e dividir sua receita em partes.

        Você pode escrever os pontos como preferir, por extenso ou em abreviações, em português ou inglês:
        “pb”, “ponto baixo”, “sc” ou “single crochet”.
        Os pontos detectados são automaticamente listados no topo da receita.

        Use o contador de carreiras para acompanhar seu projeto enquanto faz.
        """,
               counter: 0),
//            Recipe(name: "Tapete", link: "", yarn: 0, needle: 1.5, text: "bababa", counter: 0),
//            Recipe(name: "Pano", link: "", yarn: 0, needle: 0.0, text: "bababa", counter: 0)
        ]
        for recipe in recipes {
            container.mainContext.insert(recipe)
        }
        return container
    }
}
