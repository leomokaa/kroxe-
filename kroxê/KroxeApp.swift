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
                    WelcomeSheetView()
                }
        }
        .modelContainer(for: [Recipe.self]) { //cria receitas quando abre o app assim que instala
            guard !didAddSampleRecipe else { return }
            do {
                let modelContext = try $0.get().mainContext
                modelContext.insert(Recipe(name: "Minha Primeira Receita", link: "", yarn: 1, needle: 2.0, text: """
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
                                           counter: 0, isFirstRecipe: true))
                didAddSampleRecipe = true
            } catch {
                
            }
        }
    }
}
