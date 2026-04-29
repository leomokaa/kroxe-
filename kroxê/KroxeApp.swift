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
    
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: [Recipe.self]) { //cria receitas quando abre o app assim que instala
            guard isFirstLaunch else { return }
            do {
                let modelContext = try $0.get().mainContext
                modelContext.insert(Recipe(name: "Coelhinho", link: "", yarn: 2, needle: 3.5, text: "lalala"))
                modelContext.insert(Recipe(name: "Estrelinha", link: "https://apple.com", yarn: 1, needle: 2.0, text: "fafafa"))
                isFirstLaunch = false
            } catch {
                
            }
        }
    }
}
