//
//  GuideView.swift
//  kroxê
//
//  Created by User on 27/04/26.
//

import SwiftUI

struct GuideView: View {
    var body: some View {
        NavigationStack {
            ScrollView(showsIndicators: false){
                VStack(alignment: .leading, spacing: 20) {
                    Text("Conheça os pontos de crochê")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    VStack (spacing: 10) {
                        CardStitchView(stitch: Stitch.chain)
                        CardStitchView(stitch: Stitch.magicRing)
                        CardStitchView(stitch: Stitch.slipStitch)
                        CardStitchView(stitch: Stitch.singleCrochet)
                        CardStitchView(stitch: Stitch.halfDoubleCrochet)
                        CardStitchView(stitch: Stitch.doubleCrochet)
                        CardStitchView(stitch: Stitch.trebleCrochet)
                        CardStitchView(stitch: Stitch.doubleTrebleCrochet)
                        CardStitchView(stitch: Stitch.increase)
                        CardStitchView(stitch: Stitch.decrease)
                    }
                }
                .padding(.bottom, 16)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal)
            .padding(.top, -6)
            .navigationTitle("Guia")
            .navigationTitleColor(.ameixa)
            .toolbarTitleDisplayMode(.inlineLarge)
            .backgroundCream()
        }
    }
    
}

//        .backgroundCream()




#Preview {
    GuideView()
}
