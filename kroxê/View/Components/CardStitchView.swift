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
        HStack(spacing: 12){
            Image(stitch.image)
                .accessibilityHidden(true)
            
            VStack(alignment: .leading, spacing: 8){
                VStack(alignment: .leading, spacing: 1){
                    HStack(spacing: 4){
                        Text(stitch.name)
                            .font(.body.bold())
                            .foregroundStyle(Color(.ameixa))
                            .accessibilityLabel(Text("Nome do ponto: \(stitch.name)"))
                        
                        Text("(\(stitch.abreviatedName))")
                            .foregroundStyle(Color(.accent))
                            .font(.body.bold())
                            .accessibilityLabel(Text("Abreviação: \(stitch.abreviatedName)"))
                        
                        Spacer()
                    }
                    .frame(maxWidth: .infinity)
                    Text(stitch.translation)
                        .font(.footnote)
                        .foregroundStyle(Color(.secondaryLabel))
                        .accessibilityLabel(Text("Em inglês: \(stitch.translation)"))
                    
                }
                Text(stitch.description)
                    .foregroundStyle(Color(.ameixa))
                    .font(.subheadline)
                    .accessibilityLabel(Text("Descrição: \(stitch.description)"))
            }
            
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 10)
        .background(Color.white, in: RoundedRectangle(cornerRadius: 20))
        .accessibilityElement(children: .combine)
    }
}

#Preview {
    CardStitchView(stitch: Stitch.doubleTrebleCrochet)
}
