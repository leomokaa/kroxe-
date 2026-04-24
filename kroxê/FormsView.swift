//
//  FormsView.swift
//  kroxê
//
//  Created by User on 22/04/26.
//

import SwiftUI
import SwiftData
import PhotosUI

struct AddReceita: View {
     
    @Environment(\.modelContext)
    private var modelContext
    
    //  @State private var date = Date()
    @State var hours: Int = 0
    @State var minutes: Int = 0
    @State var selectedItems: [PhotosPickerItem] = []
    @State private var imageData: Image?
    @State private var newImage: PhotosPickerItem?
    //    @State private var data: date = Date()
    
    var body: some View {
                Spacer().frame(height: 10)
                HStack {
                    Button ("", systemImage: "chevron.backward.circle.fill") {
                        //                        print ("ok")
                    }
                    .font(Font.system(size: 40, weight:Font.Weight.bold))
                    .tint(.gray)
        
                    Spacer().frame(width: 60)
        
                    Text ("Criar Receita")
                        .font(Font.system(size: 25, weight:Font.Weight.bold))
        
                    Spacer().frame(width: 60)
        
                    Button ("", systemImage: "checkmark.circle.fill") {
                        //                        print ("ok")
                    }
                    .font(Font.system(size: 40, weight:Font.Weight.bold))
                    .tint(.green)
                }
        NavigationStack {
            Form{
                //            PhotosPicker(selection: $selectedItems,
                //                         matching: .any(of: [.images])) {
                //                Text("Select Photos")
                //            }
                
                Section(header: Text("Imagem:")){
                    photoPicker
                }
                
                Section(header: Text("Nome da Receita:")){
                    TextField("Digite Aqui...", text: .constant(""))
                }
                
                Section(header: Text("Tempo:")){
                    
                    //   OPCAO 1
                    HStack {
                        Picker("", selection: $hours){
                            ForEach(0..<16, id: \.self) { i in
                                Text ("\(i)").tag(i)
                            }
                        }.pickerStyle(WheelPickerStyle())
                        
                        Text ("Horas")
                        
                        Picker("", selection: $minutes){
                            ForEach(0..<60, id: \.self) { i in
                                Text("\(i)").tag(i)
                            }
                        }.pickerStyle(WheelPickerStyle())
                        
                        Text ("Minutos")
                        
                    }
                    .padding(.horizontal, 10)
                    .padding(.vertical, 2)
                    .frame(maxHeight: 120)
                }
                
                //  OPCAO 3
                //                Stepper("Horas", value: .constant(0), in: 0...100)
                //                Stepper("Minutos", value: .constant(0), in: 0...60)
                
                Section(header: Text("Tamanho da Agulha (mm):")){
                    TextField("Digite Aqui...", text: .constant(""))
                }
                
                Section(header: Text("Quantidade de Novelos:")) {
                    TextField("Digite Aqui...", text: .constant(""))
                }
                
                Section(header: Text("Link Adicional:")) {
                    TextField("Digite Aqui...", text: .constant(""))
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
        
        Spacer()
        
        Button ("Adicionar Carreira", systemImage: "plus") {
            print ("ok")
        }
        .font(Font.system(size: 20, weight:Font.Weight.bold))
        .tint(.blue)
        .buttonStyle(.borderedProminent)
        .padding(.vertical, 10)
        
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
    
}


#Preview {
    FormsView()
}
