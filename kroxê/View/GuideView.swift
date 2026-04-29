//
//  GuideView.swift
//  kroxê
//
//  Created by User on 27/04/26.
//

import SwiftUI

struct GuideView: View {
    var body: some View {
        VStack{
            VStack(alignment: .leading){
                Text("Guia")
                    .font(.largeTitle.bold())
                    .foregroundStyle(Color.ameixa)
                    .padding()
                
                NavigationStack {
                    ScrollView(showsIndicators: false){
                            VStack (spacing: 10) {
                                //                        ForEach(stitch.enumerated(), id: \.offset) { index, stitch in
                                CardStitchView(stitch: Stitch.doubleTrebleCrochet)
                                CardStitchView(stitch: Stitch.chain)
                            }
                        }
                    }
                    
                }
               
            .padding(.bottom, 16)
            }
        
        }
    
//        .backgroundCream()
    

    }

#Preview {
    GuideView()
}
