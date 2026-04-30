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
            Recipe(name: "Estrelinha", link: "", yarn: 1, needle: 0.0, text: "lalala", counter: 0),
            Recipe(name: "Coelhinho", link: "blablbla", yarn: 2, needle: 3.5, text: """
            #Cabeça
            Rnd 1. 7 sc in magic ring (7)
            Rnd 2. 7 inc (14)
            Rnd 3. (1 sc, inc) x 7 (21)
            Rnd 4. (2 sc, inc) x 7 (28)
            Rnd 5. (3 sc, inc) x 7 (35)
            Rnd 6 - 13. sc in each (35)
            Add safety eyes between rounds 10 and 11, 7 st apart
            Stuff
            Rnd 14. (3 sc, dec) x 7 (28)
            Rnd 15. (2 sc, dec) x 7 (21)
            Rnd 16. (1 sc, dec) x 7 (14)
            Stuff some more
            Rnd 17. 14 dec (7)
            sl st and f.o.
            Embroider a nose between rounds 10 and 11, mouth from 11  to 12
            
            #Ears (make 2)
            Rnd 1. 6 sc in magic ring (6)
            Rnd 2. 6 inc (12)
            Rnd 3. (2 sc, inc) x 4 (16)
            Rnd 4 - 9. sc in each (16)
            Rnd 10. (6 sc, dec) x 2 (14)
            Rnd 11 - 13. sc in each (14)
            Rnd 14. (5 sc, dec) x 2 (12)
            Rnd 15 - 16. sc in each (12)
            Rnd 17. (4 sc, dec) x 2 (10)
            Rnd 18. sc in each (10)
            If you prefer longer you can add 1-3 rounds
            sl st and f.o., leave long tail to sew
            Don't stuff!
            Sew an ear to each side of head, between rounds 5 and 6
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
