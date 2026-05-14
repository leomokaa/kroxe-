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
            Recipe(name: "Minha Primeira Receita",link: "", yarn: 1, needle: 2.0, text: """
        #Círculo
        Faça seu primeiro círculo, a extensão dessa receita pode gerar enfeites como tapete e centro de mesa.

        Carreira 1: Anel mágico com 6 pa, pbx no primeiro pa para fechar o círculo [6]
        Carreira 2: 3 corr, 1 pa no mesmo ponto, 5 aum, pbx no primeiro pa [12]
        Carreira 3: 3 corr, 1 aum, (1 pa, 1 aum) x5, pbx no primeiro pa [18]
        Carreira 4: 3 corr, 1 aum, 1 pa, (1 pa, 1 aum, 1 pa) x5, pbx no primeiro pa [24]
        Carreira 5: 3 corr, 2 pa, 1 aum, (3 pa, 1 aum) x5, pbx no primeiro pa [30]
        Corte e arremate o fio.
        
        #Dicas
        Digite ”hashtag” no início da linha para escrever um título e dividir sua receita em partes.

        Você pode escrever os pontos como preferir, por extenso ou em abreviações, em português ou inglês:
        “pb”, “ponto baixo”, “sc” ou “single crochet”.
        Os pontos detectados são automaticamente listados no topo da receita. 
        Para um melhor funcionamento, evite escrever abreviações divididas com ponto: ”p.b” ou ”p.b.”

        Use o contador de carreiras para acompanhar seu projeto enquanto faz.
        """,
                   counter: 0, isFirstRecipe: true),
//            Recipe(name: "Tapete", link: "", yarn: 0, needle: 1.5, text: "bababa", counter: 0),
//            Recipe(name: "Pano", link: "", yarn: 0, needle: 0.0, text: "bababa", counter: 0)
        ]
        for recipe in recipes {
            container.mainContext.insert(recipe)
        }
        return container
    }
}
