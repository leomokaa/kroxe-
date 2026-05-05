//
//  backgroundCream.swift
//  kroxê
//
//  Created by User on 27/04/26.
//

import SwiftUI

extension View {
    func backgroundCream() -> some View {
        modifier(BackgroundCream())
    }
}

struct BackgroundCream: ViewModifier {
    func body(content: Content) -> some View {
        ZStack {
            Color.creme.ignoresSafeArea()
            content
        }
    }
}
