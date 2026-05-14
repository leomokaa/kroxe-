//
//  CardTagView.swift
//  kroxê
//
//  Created by User on 28/04/26.
//

import SwiftUI

struct TagCardView: View {
    let tagIcon: String
    let tagName: String
    
    var body: some View {
        HStack (spacing: 4){
//            Image(systemName: tagIcon)
            Text(tagName)
                .multilineTextAlignment(.leading)
        }
        .foregroundStyle(.ameixa)
        .font(.footnote.weight(.medium))
        .padding(.vertical, 4)
        .padding(.horizontal, 8)
        .background(Color.lightLavanda, in: RoundedRectangle(cornerRadius: 8))
    }
}

#Preview {
    TagCardView(tagIcon: "wand.and.outline", tagName: "Agulha: 3.5 mm")
}
