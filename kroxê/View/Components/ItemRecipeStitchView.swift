//
//  CardRecipeStitchView.swift
//  kroxê
//
//  Created by User on 28/04/26.
//

import SwiftUI

struct CardRecipeStitchView: View {
    var stitch: Stitch
    
    var cardWidth: CGFloat = 67
    
    var body: some View {
        VStack (spacing: 4) {
            VStack{
                Image(stitch.image)
                    .frame(width: cardWidth, height: 73)
                
            }
            .padding(.horizontal, 6)
            .padding(.vertical, 4)
            .background(Color.lightRosaSuave, in: RoundedRectangle(cornerRadius: 10))
            
            Text(stitch.abreviatedName)
                .multilineTextAlignment(.center)
                .font(.caption.bold())
                .foregroundColor(.ameixa)
                .frame(maxWidth: .infinity)
        }
        .frame(width: cardWidth + 10)
    }
}

#Preview {
    CardRecipeStitchView(stitch: Stitch.doubleTrebleCrochet)
}
