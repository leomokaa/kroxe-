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
    @State private var imageData: Data?
    @State private var newImage: PhotosPickerItem?
    
    var body: some View {
        Form{
            Section(){
                photoPicker
            }
            
            Section(header: Text("Nome da Receita*")){
                TextField("Digite o nome", text: $nameEdit)
                    .foregroundStyle(.ameixa)
            }
            .listRowBackground(Color.cremeBranco)
            
            Section(header: Text("Informações adicionais")){
                HStack {
                    Text("Agulha: \(needleEdit.formatted(.number.precision(.fractionLength(1)))) mm")
                        .foregroundStyle(.ameixa)
                    Stepper(
                        "",
                        value: $needleEdit,
                        in: 0.0 ... 25,
                        step: 0.5
                    )
                    .foregroundStyle(.accent)
                }
                HStack {
                    Text("Nº de Novelos: \(yarnEdit)")
                        .foregroundStyle(.ameixa)
                    Stepper(
                        "",
                        value: $yarnEdit,
                        in: 0 ... 300,
                        step: 1
                    )
                    .foregroundStyle(.accent)
                }
            }
            .listRowBackground(Color.cremeBranco)
            
            Section(header: Text("Link do Tutorial")) {
                TextField("Digite o url do tutorial", text: $linkEdit)
                    .foregroundStyle(.ameixa)
            }
            .listRowBackground(Color.cremeBranco)
            
            Section(header: Text("Receita*"), footer: Text("Para escrever sua receita, você pode criar títulos e separar suas etapas. Para isso, escreva # antes do título, pule a linha e continue sua receita.")) {
                
                ZStack(alignment: .leading) {
                    if textEdit.isEmpty {
                        VStack {
                            Text("Digite sua receita")
                                .padding(.top, 10)
                                .padding(.leading, -1)
                                .foregroundColor(Color.secondary.opacity(0.45))
                                .fontWeight(.regular)
                                .font(.body)
                            Spacer(minLength: 20)
                        }.zIndex(1)
                    }
                    
                    VStack {
                        TextEditor(text: $textEdit)
                            .frame(minHeight: 60)
                            .padding(.horizontal, -5)
                            .foregroundStyle(.ameixa)
                        Spacer()
                    }.zIndex(0)
                }
                
            }
            .listRowBackground(Color.cremeBranco)
        }
        .onAppear {
            nameEdit = recipe.name
            imageData = recipe.photo
            yarnEdit = recipe.yarn
            needleEdit = recipe.needle
            linkEdit = recipe.link 
            textEdit = recipe.text
        }
        .listRowSpacing(10)
        .listSectionSpacing(10)
        
        .scrollContentBackground(.hidden)
        .backgroundCream()
        
        .toolbar {
            ToolbarItem(placement: .confirmationAction) {
                Button {
                    editRecipe()
                    dismiss()
                }
                label: {
                    Image(systemName: "checkmark")
                }
                .buttonStyle(.borderedProminent)
                .disabled(submitPermission())
            }
        }
        .navigationTitle(Text("Editar Receita"))
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
    
    func editRecipe() {
        recipe.name = nameEdit
        recipe.photo = imageData
        recipe.link = linkEdit
        recipe.yarn = yarnEdit
        recipe.needle = needleEdit
        recipe.text = textEdit
    }
    
    func submitPermission() -> Bool {
        if (nameEdit.isEmpty || textEdit.isEmpty) {
            return true
        } else {
            return false
        }
    }
}

#Preview {
    EditRecipeView(
        recipe: Recipe(name: "Amanda", link: "", yarn: 100, needle: 10.0, text: "teste", counter: 0)
    )
}
