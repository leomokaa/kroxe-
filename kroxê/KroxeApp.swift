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

    var body: some Scene {
        WindowGroup {
            ContentView()
        }.modelContainer(for: [Recipe.self])
    }
}
