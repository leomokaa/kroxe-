//
//  CardStitchView.swift
//  kroxê
//
//  Created by User on 28/04/26.
//

import SwiftUI

struct CardStitchView: View {
    var stitch: Stitch
    
    var body: some View {
        //nao mexer
        VStack{
            HStack(spacing: 12){
                Image(stitch.image)
             
                VStack(alignment: .leading, spacing: 7){
                    VStack(alignment: .leading, spacing: 0){
                        
                        HStack(spacing: 4){
                            Text(stitch.name)
                                .font(.body.bold())
                                .foregroundStyle(Color(.ameixa))
                            Text("(\(stitch.abreviatedName))")
                                .foregroundStyle(Color(.accent))
                                .font(.body.bold())
                        }
                        Text(stitch.translation)
                            .font(.footnote)
                            .foregroundStyle(Color(.secondaryLabel))
                    }
                    Text(stitch.description)
                        .foregroundStyle(Color(.ameixa))
                }
                
            }
            .padding(.horizontal, 12)
            .padding(.vertical, 8)
            .background(Color.white, in: RoundedRectangle(cornerRadius: 20))
        }
        .backgroundCream()
    }
}

#Preview {
    CardStitchView(stitch: Stitch.doubleTrebleCrochet)
}
