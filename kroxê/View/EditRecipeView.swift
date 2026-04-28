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
    var recipe: Recipe
    
    @State var nameEdit: String = ""
    @State var linkEdit: String = ""
    @State var yarnEdit: Int = 0
    @State var needleEdit: Float = 0
    @State var textEdit: String = ""
    @State var selectedItems: [PhotosPickerItem] = []
    @State private var imageData: Data?
    @State private var newImage: PhotosPickerItem?
    
    var body: some View {
        
        NavigationStack {
            Form{
                Section(header: Text("Imagem:")){
                    photoPicker
                }
                Section(header: Text("Nome da Receita:")){
                    TextField("Digite Aqui...", text: $nameEdit)
                }
                Section(header: Text("Informações adicionais:")){
                    HStack {
                        Stepper(
                            "Tamanho da Agulha: \(needleEdit.formatted(.number.precision(.fractionLength(1))))",
                            value: $needleEdit,
                            in: 0.0 ... 25,
                            step: 0.5
                        )
                    }
                    HStack {
                        Stepper(
                            "Quantidade de Novelos: \(yarnEdit)",
                            value: $yarnEdit,
                            in: 0 ... 300,
                            step: 1
                        )
                    }
                }
                Section(header: Text("Link Adicional:")) {
                    TextField("Digite Aqui...", text: $linkEdit)  //TODO: fazer textfields aparecerem o valor atual
                }
                Section(header: Text("Receita:")) {
                    TextField("Digite Aqui...", text: $textEdit, axis: .vertical)
                        .lineLimit(10, reservesSpace: true)
                }
            }
            .onAppear {
                nameEdit = recipe.name
                yarnEdit = recipe.yarn
                needleEdit = recipe.needle
                linkEdit = recipe.link ?? ""
                textEdit = recipe.text
            }
        }
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button ("", systemImage: "chevron.backward") {
                    dismiss()
                }
                .font(Font.system(size: 40, weight:Font.Weight.bold))
                .tint(.gray)
            }
            ToolbarItem(placement: .principal) {
                HStack {
                    Text ("Criar Receita")
                        .font(Font.system(size: 25, weight:Font.Weight.bold))
                }
            }
            ToolbarItem(placement: .topBarTrailing) {
                Button ("", systemImage: "checkmark") {
                    EditRecipe()
                    dismiss()
                }
                .disabled(submitPermission())
                .font(Font.system(size: 40, weight:Font.Weight.bold))
                .tint(.green)
            }
        }
    }
    
    private var photoPicker: some View {
        PhotosPicker(selection: $newImage) {
            Group {
                if let imageData, let uiImage = UIImage(data: imageData) {
                    Image(uiImage: uiImage)
                        .resizable()
                        .scaledToFit()
                        .clipShape(RoundedRectangle(cornerRadius: 16))
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
                imageData = try await newImage.loadTransferable(type: Data.self)
            }
        }
    }
    
    func EditRecipe() {
        recipe.name = nameEdit
        recipe.link = linkEdit
        recipe.yarn = yarnEdit
        recipe.needle = needleEdit
        if imageData != nil {
            recipe.photo = imageData
        }
    }
    
    func submitPermission() -> Bool {
        if (nameEdit == "" || needleEdit == 0.0 || textEdit == "") {
            return true
        } else {
            return false
        }
    }
}

#Preview {
    EditRecipeView(
        recipe: Recipe(name: "Amanda", yarn: 100, needle: 10.0, text: "teste")
    )
}
