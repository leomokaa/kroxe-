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
            Recipe(name: "Coelhinho", link: "", yarn: 2, needle: 3.5, text: "lalala"),
            Recipe(name: "Estrelinha", link: "blablbla", yarn: 1, needle: 0.0, text: "fafafa"),
            Recipe(name: "Tapete", link: "", yarn: 0, needle: 1.5, text: "bababa"),
            Recipe(name: "Pano", link: "", yarn: 0, needle: 0.0, text: "bababa")
        ]
        for recipe in recipes {
            container.mainContext.insert(recipe)
        }
        return container
    }
}
