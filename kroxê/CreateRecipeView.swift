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
    @State var yarn: Int = 0   //tirar textfield?
    @State var needle: Float = 0  //tirar textfield?
    @State var text: String = ""
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
                createRecipe()
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
                    TextField("Digite Aqui...", text: $name)
                }

                Section(header: Text("Tamanho da Agulha (mm):")){
                    TextField("Digite Aqui...", value: $needle, format: .number)  //tirar textfield?
                }
                
                Section(header: Text("Quantidade de Novelos:")) {
                    TextField("Digite Aqui...", value: $yarn, format: .number)  //tirar textfield?
                }
                
                Section(header: Text("Link Adicional:")) {
                    TextField("Digite Aqui...", text: $link)
                }
                
                Section(header: Text("Receita:")) {
                    TextField("Digite Aqui...", text: $text, axis: .vertical)
                        .lineLimit(10, reservesSpace: true)
                }
                
            }
        }
//        .toolbar {
//            ToolbarItem(placement: .topBarLeading) {
//                Button ("", systemImage: "chevron.backward.circle.fill") {
//                    //                        print ("ok")
//                }
//                .font(Font.system(size: 40, weight:Font.Weight.bold))
//                .tint(.gray)
//            }
//            
//            ToolbarItem(placement: .principal) {
//                HStack {
//                    Text ("Criar Receita")
//                        .font(Font.system(size: 25, weight:Font.Weight.bold))
//                }
//            }
//            
//            ToolbarItem(placement: .topBarTrailing) {
//                Button ("", systemImage: "checkmark.circle.fill") {
//                    //                        print ("ok")
//                }
//                .font(Font.system(size: 40, weight:Font.Weight.bold))
//                .tint(.green)
//            }
//        }
        
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

    func createRecipe() {
        let newRecipe = recipe(
            name: name,
            link: link,
            yarn: yarn,
            needle: needle,
            text: text
        )
        modelContext.insert(newRecipe)
    }
    
    func submitPermission() -> Bool {
        if (name == "" || yarn == 0 || needle == 0.0 || text == "") {
            return true
        } else {
            return false
        }
    }
}


#Preview {
    CreateRecipeView()
}
