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
    
    var body: some View {
        VStack (spacing: 4) {
            VStack{
                Button (action: {shouldPresentSheet.toggle() }) {
                    Image(stitch.image)
                }
                .frame(width: 67, height: 73)
                .sheet(isPresented: $shouldPresentSheet) {
                } content: {
                    StitchSheetView(stitch: stitch)
                        .presentationDetents([.height(310)])
                }
            }
            .padding(.horizontal, 6)
            .padding(.vertical, 4)
            .background(Color.lightRosaSuave, in: RoundedRectangle(cornerRadius: 10))
            
            Text(stitch.name)
                .multilineTextAlignment(.center)
                .font(.caption.bold())
                .foregroundColor(.ameixa)
                .frame(maxWidth: .infinity)
        }
    }
}

#Preview {
    CardRecipeStitchView(stitch: Stitch.doubleTrebleCrochet)
}
