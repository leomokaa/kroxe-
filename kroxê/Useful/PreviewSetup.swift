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
            Recipe(name: "Coelhinho", link: "", yarn: 2, needle: 3.5, text: "lalala", counter: 0),
            Recipe(name: "Estrelinha", link: "blablbla", yarn: 1, needle: 0.0, text: """
            #titulo
            Rnd 1. 7 sc in magic ring (7)
            Rnd 2. 7 inc (14)
            Rnd 3. (1 single crochet, inc) x 7 (21)
            Rnd 4. (2 sc, inc) x 7 (28)
            Rnd 5. (3 sc, inc) x 7 (35)
            Rnd 6 - 13. sc in each (35)
            Add safety eyes between rounds 10 and 11, 7 st apart
            Stuff
            
            #titulo 2
            Rnd 14. (3 sc, dec) x 7 (28)
            Rnd 15. (2 sc, dec) x 7 (21)
            Rnd 16. (1 sc, dec) x 7 (14)
            Stuff some more
            Rnd 17. 14 dec (7)
            sl st and f.o.
            Embroider a nose between rounds 10 and 11, mouth from 11  to 12
            """,
                   counter: 0),
            Recipe(name: "Tapete", link: "", yarn: 0, needle: 1.5, text: "bababa", counter: 0),
            Recipe(name: "Pano", link: "", yarn: 0, needle: 0.0, text: "bababa", counter: 0)
        ]
        for recipe in recipes {
            container.mainContext.insert(recipe)
        }
        return container
    }
}
