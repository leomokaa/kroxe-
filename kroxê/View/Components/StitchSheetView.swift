//
//  StitchSheetView.swift
//  kroxê
//
//  Created by User on 30/04/26.
//

import SwiftUI

struct StitchSheetView: View {
    @Environment(\.dismiss) private var dismiss
    var stitch: Stitch
    
    var body: some View {
        NavigationStack {
            VStack (spacing: 12) {
                Image(stitch.image)
                    .padding(.horizontal, 6)
                    .padding(.vertical, 4)
                    .background(Color.lightRosaSuave, in: RoundedRectangle(cornerRadius: 10))
                VStack (spacing: 9){
                    VStack (spacing: 1){
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
                        .font(.subheadline)
                        .multilineTextAlignment(.center)
                        .frame(maxWidth: 300)
                }
            }
            .navigationTitle(stitch.name)
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(leading:
                                    Button(action: {dismiss()}) {
                Image(systemName: "xmark")
            }
            )
        }
    }
}

#Preview {
    StitchSheetView(stitch: Stitch.chain)
}
