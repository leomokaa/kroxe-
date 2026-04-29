//
//  FormsView.swift
//  kroxê
//
//  Created by User on 22/04/26.
//

import SwiftUI
import SwiftData
import PhotosUI

struct CreateRecipeView: View {
    
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext)
    private var modelContext
    
    @State var name: String = ""
    @State var link: String = ""
    @State var yarn: Int = 0
    @State var needle: Float = 0
    @State var text: String = ""
    @State var selectedItems: [PhotosPickerItem] = []
    @State private var imageData: Data? = nil
    @State private var newImage: PhotosPickerItem? = nil
    
    var body: some View {
        Form{
            Section(){
                photoPicker
            }
            Section(header: Text("Nome da Receita*")){
                TextField("Digite Aqui...", text: $name)
            }
            .listRowBackground(Color.cremeBranco)
            Section(header: Text("Informações adicionais:")){
                HStack {
                    Stepper(
                        "Tamanho da Agulha: \(needle.formatted(.number.precision(.fractionLength(1))))",
                        value: $needle,
                        in: 0.0 ... 25,
                        step: 0.5
                    )
                }
                HStack {
                    Stepper(
                        "Quantidade de Novelos: \(yarn)",
                        value: $yarn,
                        in: 0 ... 300,
                        step: 1
                    )
                }
            }
            Section(header: Text("Link Adicional:")) {
                TextField("Digite Aqui...", text: $link)
            }
            Section(header: Text("Receita:")) {
                TextField("Digite Aqui...", text: $text, axis: .vertical)
                    .lineLimit(10, reservesSpace: true)
            }
        }
        .scrollContentBackground(.hidden)
        .backgroundCream()
        .toolbar {
            ToolbarItem(placement: .confirmationAction) {
                Button {
                    createRecipe()
                    dismiss()
                }
                label: {
                    Image(systemName: "checkmark")
                }
                .buttonStyle(.borderedProminent)
                .disabled(name.isEmpty || needle == 0.0 || text.isEmpty)
            }
        }
        .navigationTitle("Criar Receita")
        .navigationTitleColor(.ameixa)
        .toolbarTitleDisplayMode(.inline)
        
        .padding(.top, -32)
    }
    
    private var photoPicker: some View {
        PhotosPicker(selection: $newImage) {
            Group {
                if let imageData, let uiImage = UIImage(data: imageData) {
                    HStack(alignment: .center) {
                        Image(uiImage: uiImage)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 370,height: 148)
                            .clipShape(RoundedRectangle(cornerRadius: 32))
                    }
                    .frame(maxWidth: .infinity)
                } else {
                    VStack(spacing: 4) {
                        Image(systemName: "photo.badge.plus.fill")
                            .font(.largeTitle)
                        Text("370x129")
                            .font(.callout.bold())
                    }
                    .frame(maxWidth: .infinity)
                    .frame(width: 370, height: 148)
                    .background(Color.cremeBranco)
                    .clipShape(RoundedRectangle(cornerRadius: 32))
                }
            }
        }
        .listRowBackground(Color.clear)
        .onChange(of: newImage) {
            guard let newImage else { return }
            Task {
                imageData = try await newImage.loadTransferable(type: Data.self)
            }
        }
    }
    
    func createRecipe() {
        let newRecipe = Recipe(
            name: name,
            photo: imageData,
            link: link,
            yarn: yarn,
            needle: needle,
            text: text
        )
        modelContext.insert(newRecipe)
    }
}


#Preview {
    CreateRecipeView()
}
