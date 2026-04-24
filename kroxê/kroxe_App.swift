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
    @State private var receitasList: [Receita]
    
    init() {
        self.receitasList = [
            Receita(name: "coelho", link: "lalala", yarn: 12, needle: 2.0, text: "lalala"),
            Receita(name: "blusa", link: "blablbla", yarn: 7, needle: 4.1, text: "fafafa"),
            Receita(name: "dinossauro", link: "gegege", yarn: 5, needle: 3.4, text: "lilili")
        ]
    }
    var body: some Scene {
        WindowGroup {
            PageView()
        }.modelContainer(for: [Receita.self])
    }
}
