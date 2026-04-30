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
    @State private var imageData: Data? = nil
    @State private var newImage: PhotosPickerItem? = nil
    @State private var counter: Int = 0
    
    var body: some View {
        Form{
            Section(){
                photoPicker
            }
            
            Section(header: Text("Nome da Receita*")){
                TextField("Digite o nome", text: $name)
                    .foregroundStyle(.ameixa)
            }
            .listRowBackground(Color.cremeBranco)
            
            Section(header: Text("Informações adicionais")){
                HStack {
                    Text("Agulha: \(needle.formatted(.number.precision(.fractionLength(1)))) mm")
                        .foregroundStyle(.ameixa)
                    Stepper(
                        "",
                        value: $needle,
                        in: 0.0 ... 25,
                        step: 0.5
                    )
                    .foregroundStyle(.accent)
                }
                HStack {
                    Text("Nº de Novelos: \(yarn)")
                        .foregroundStyle(.ameixa)
                    Stepper(
                        "",
                        value: $yarn,
                        in: 0 ... 300,
                        step: 1
                    )
                    .foregroundStyle(.accent)
                }
            }
            .listRowBackground(Color.cremeBranco)
            
            Section(header: Text("Link do Tutorial")) {
                TextField("Digite o url do tutorial", text: $link)
                    .foregroundStyle(.ameixa)
            }
            .listRowBackground(Color.cremeBranco)
            
            Section(header: Text("Receita*"), footer: Text("Para escrever sua receita, você pode criar títulos e separar suas etapas. Para isso, escreva # antes do título, pule a linha e continue sua receita.")) {
                
                ZStack(alignment: .leading) {
                    if text.isEmpty {
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
                        TextEditor(text: $text)
                            .frame(minHeight: 60)
                            .padding(.horizontal, -5)
                            .foregroundStyle(.ameixa)
                        Spacer()
                    }.zIndex(0)
                }
                
            }
            .listRowBackground(Color.cremeBranco)
            
        }
        .listRowSpacing(10)
        .listSectionSpacing(10)
        
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
                .disabled(name.isEmpty || text.isEmpty)
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
            text: text,
            counter: counter,
        )
        modelContext.insert(newRecipe)
    }
}


#Preview {
    CreateRecipeView()
}
