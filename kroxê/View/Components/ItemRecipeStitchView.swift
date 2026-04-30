//
//  ItemRecipeStitchView.swift
//  kroxê
//
//  Created by User on 28/04/26.
//

import SwiftUI

struct CardRecipeStitchView: View {
    var stitch: Stitch
    @State var shouldPresentSheet: Bool = false
    @State private var sheetHeight: CGFloat = .zero
    var cardWidth: CGFloat = 67
    
    var body: some View {
        VStack (spacing: 4) {
            VStack{
                Button (action: {shouldPresentSheet.toggle() }) {
                    Image(stitch.image)
                        .padding(10.0)
                }
                .frame(width: cardWidth, height: 73)
                .sheet(isPresented: $shouldPresentSheet) {
                    print("Sheet dismissed!")
                } content: {
                    CardStitchView(stitch: stitch)
                        .presentationDetents([.height(200)])
                }
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
