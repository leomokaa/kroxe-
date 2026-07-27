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
    @State private var isFirstRecipe: Bool = false
    
    var body: some View {
        Form{
            Section(){
                photoPicker
                    .accessibilityLabel(Text("Escolha uma foto para a receita"))
            }
            
            Section(header: Text("Nome da Receita*").accessibilityLabel(Text("Nome da Receita"))){
                TextField("Digite o nome da receita", text: $name)
                    .foregroundStyle(.ameixa)
            }
            .listRowBackground(Color.cremeBranco)
            .preferredColorScheme(.light)
            
            Section(header: Text("Informações adicionais").accessibilityLabel(Text("Informações adicionais"))){
                HStack {
                    Text("Agulha: \(needle.formatted(.number.precision(.fractionLength(1)))) mm")
                        .foregroundStyle(.ameixa)
                        .accessibilityHidden(true)
                    Stepper(
                        "",
                        value: $needle,
                        in: 0.0 ... 25,
                        step: 0.5
                    )
                    .foregroundStyle(.accent)
                    .preferredColorScheme(.light)
                    .accessibilityLabel(Text("Selecione o tamanho da agulha"))
                    .accessibilityValue((needle.formatted(.number.precision(.fractionLength(1)))))
                }
                .accessibilityElement(children: .combine)
                
                HStack {
                    Text("Nº de Novelos: \(yarn)")
                        .foregroundStyle(.ameixa)
                        .accessibilityHidden(true)
                    Stepper(
                        "",
                        value: $yarn,
                        in: 0 ... 300,
                        step: 1
                    )
                    .foregroundStyle(.accent)
                    .preferredColorScheme(.light)
                    .accessibilityValue(String(yarn))
                    .accessibilityLabel(Text("Selecione a quantidade de novelos"))
                }
                .accessibilityElement(children: .combine)
            }
            .listRowBackground(Color.cremeBranco)
            
            Section(header: Text("Link do Tutorial")) {
                TextField("Digite o url do tutorial", text: $link)
                    .foregroundStyle(.ameixa)
            }
            .listRowBackground(Color.cremeBranco)
            .preferredColorScheme(.light)
            
            Section(header: Text("Receita*")
                .accessibilityLabel(Text("Receita")), footer: Text("Para escrever sua receita, você pode criar títulos e separar suas etapas. Para isso, escreva # antes do título, pule a linha e continue sua receita.").accessibilityHidden(true)) {
                
                ZStack(alignment: .leading) {
                    if text.isEmpty {
                        VStack {
                            Text("Digite sua receita")
                                .padding(.top, 10)
                                .padding(.leading, -1)
                                .foregroundColor(Color.secondary.opacity(0.45))
                                .fontWeight(.regular)
                                .font(.body)
                                .accessibilityHidden(true)
                            Spacer(minLength: 20)
                        }.zIndex(1)
                         .preferredColorScheme(.light)
                    }

                    VStack {
                        TextEditor(text: $text)
                            .frame(minHeight: 60)
                            .padding(.horizontal, -5)
                            .foregroundStyle(.ameixa)
                            .accessibilityLabel(Text("Digite sua receita"))
        
                        Spacer()
                    }.zIndex(0)
                    .preferredColorScheme(.light)
                }
                .accessibilityHint(Text("Para escrever sua receita, você pode criar títulos e separar suas etapas. Para isso, digite # antes do título, pule a linha e continue sua receita."))
                
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
                .accessibilityLabel(Text("Salvar receita"))
                .accessibilityHint(Text("Para salvar a receita, é obrigatório adicionar um nome e digitá-la na caixa de texto"))
                .accessibilityValue(false ? "Habilitado" : "Desabilitado")
            }
            
            ToolbarItem(placement: .cancellationAction) {
                Button {
                    dismiss()
                }
                label: {
                    Image(systemName: "xmark")
                }
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
                        Rectangle()
                            .aspectRatio(3/1, contentMode: .fit)
                            .overlay {
                                Image(uiImage: uiImage)
                                    .resizable()
                                    .scaledToFill()
                            }
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                    }
                    .frame(maxWidth: .infinity)
                } else {
                    VStack(spacing: 4) {
                        Rectangle()
                            .aspectRatio(3/1, contentMode: .fit)
                            .overlay {
                                VStack(spacing: 4) {
                                    Image(systemName: "photo.badge.plus.fill")
                                        .font(.largeTitle)
                                        .foregroundStyle(.accent)
                                    Text("370x129")
                                        .font(.callout.bold())
                                        .foregroundStyle(.accent)
                                }
                            }
                            .foregroundStyle(.cremeBranco)
                        
                    }
                    .frame(maxWidth: .infinity)
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
            isFirstRecipe: isFirstRecipe
        )
        modelContext.insert(newRecipe)
    }
}


#Preview {
    CreateRecipeView()
}
