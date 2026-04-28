//
//  GuideView.swift
//  kroxê
//
//  Created by User on 27/04/26.
//

import SwiftUI

struct GuideView: View {
    var body: some View {
        VStack (alignment: .leading) {
            Text("Guia")
                .font(.largeTitle.bold())
                .foregroundStyle(Color.ameixa)
            Spacer()
        }
        .backgroundCream()
    }
}

#Preview {
    GuideView()
}
