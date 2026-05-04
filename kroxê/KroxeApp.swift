//
//  kroxe_App.swift
//  kroxê
//
//  Created by User on 16/04/26.
//

import SwiftUI
import SwiftData


@main
struct kroxe_App: App {

    @AppStorage("isFirstLaunch") var isFirstLaunch = true
    @AppStorage("didAddSampleRecipe") var didAddSampleRecipe = false
    
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .sheet(isPresented: $isFirstLaunch) {
                    Text("Onboard")
                }
        }
        .modelContainer(for: [Recipe.self]) { //cria receitas quando abre o app assim que instala
            guard !didAddSampleRecipe else { return }
            do {
                let modelContext = try $0.get().mainContext
                modelContext.insert(Recipe(name: "Minha Primeira Receita", link: "", yarn: 0, needle: 0.0, text: """
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
                   counter: 0))
                didAddSampleRecipe = true
            } catch {
                
            }
        }
    }
}
