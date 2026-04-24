//
//  EditRecipeView.swift
//  kroxê
//
//  Created by User on 24/04/26.
//

import SwiftUI
import SwiftData
import PhotosUI

struct EditRecipeView: View {
    
    @Environment(\.dismiss) private var dismiss
    var recipe: recipe
    
    @State var nameEdit: String = ""
    @State var linkEdit: String = ""
    @State var yarnEdit: Int = 0
    @State var needleEdit: Float = 0
    @State var textEdit: String = ""
    @State var selectedItems: [PhotosPickerItem] = []
    @State private var imageData: Image?
    @State private var newImage: PhotosPickerItem?
    
    var body: some View {
        Spacer().frame(height: 10)
        HStack {
            Button ("", systemImage: "chevron.backward.circle.fill") {
                dismiss()
            }
            .font(Font.system(size: 40, weight:Font.Weight.bold))
            .tint(.gray)
            
            Spacer().frame(width: 60)
            
            Text ("Criar Receita")
                .font(Font.system(size: 25, weight:Font.Weight.bold))
            
            Spacer().frame(width: 60)
            
            Button ("", systemImage: "checkmark.circle.fill") {
                EditRecipe()
                dismiss()
            }
            .disabled(submitPermission())
            .font(Font.system(size: 40, weight:Font.Weight.bold))
            .tint(.green)
        }
        NavigationStack {
            Form{
                
                Section(header: Text("Imagem:")){
                    photoPicker
                }
                
                Section(header: Text("Nome da Receita:")){
                    TextField("Digite Aqui...", text: $nameEdit)
                }
                
                Section(header: Text("Tamanho da Agulha (mm):")){
                    TextField("Digite Aqui...", value: $needleEdit, format: .number)  //tirar textfield?
                }
                
                Section(header: Text("Quantidade de Novelos:")) {
                    TextField("Digite Aqui...", value: $yarnEdit, format: .number)  //tirar textfield?
                }
                
                Section(header: Text("Link Adicional:")) {
                    TextField("Digite Aqui...", text: $linkEdit)  //TODO: fazer textfields aparecerem o valor atual
                }
                
                Section(header: Text("Receita:")) {
                    TextField("Digite Aqui...", text: $textEdit, axis: .vertical)
                        .lineLimit(10, reservesSpace: true)
                }
                
            }
            
        }
    }
    
    private var photoPicker: some View {
        PhotosPicker(selection: $newImage) {
            Group {
                if let imageData {
                    imageData
                        .resizable()
                        .scaledToFit()
                } else {
                    Image(systemName: "photo.badge.plus.fill")
                        .tint(.gray)
                        .font(.largeTitle)
                        .frame(height: 120)
                        .frame(maxWidth: .infinity)
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                        .overlay {
                            RoundedRectangle(cornerRadius: 8, style: .continuous)
                                .stroke(Color(UIColor.systemGray4), lineWidth: 2)
                        }
                }
            }
        }
        .onChange(of: newImage) {
            guard let newImage else { return }
            Task {
                imageData = try await newImage.loadTransferable(type: Image.self)
            }
        }
    }
    
    func EditRecipe() {
        recipe.name = nameEdit
        recipe.link = linkEdit
        recipe.yarn = yarnEdit
        recipe.needle = needleEdit
        //TODO: adicionar a parte de foto
    }
    
    func submitPermission() -> Bool {
        if (nameEdit == "" || yarnEdit == 0 || needleEdit == 0.0 || textEdit == "") {
            return true
        } else {
            return false
        }
    }
    
}

#Preview {
    EditRecipeView()
}
