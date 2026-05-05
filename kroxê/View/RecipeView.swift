//
//  RecipeView.swift
//  kroxê
//
//  Created by User on 28/04/26.
//

import SwiftUI
import OrderedCollections
import SwiftData

//extension String {
//    func highlighted(keywords: [String]) -> String {
//        var result: String = self
//        for keyword in keywords {
//            let keywordWithoutSpaces = keyword.replacingOccurrences(of: " ", with: "")
//            result = result.replacingOccurrences(of: keyword, with: "**\(keywordWithoutSpaces)**")
//        }
//        return result
//    }
//}

struct RecipeView: View {
    
    @Environment(\.modelContext)
    var modelContext //modelContext.delete(model)
    @Environment(\.dismiss) private var dismiss
    
    var recipe: Recipe
    @State var bool: Bool = true
    @State private var isDeleting: Bool = false
    
    @Namespace private var namespace
    
    var body: some View {
        ScrollView(showsIndicators: false){
            VStack(alignment: .leading, spacing: 20) {
                VStack(alignment: .leading, spacing: 12) {
                    VStack{
                        if let data = recipe.photo {
                            if let uiImage = UIImage(data: data) {
                                HStack(alignment: .center){
                                    NavigationLink {
                                        Image(uiImage: uiImage)
                                            .resizable()
                                            .scaledToFit()
                                            .navigationTransition(.zoom(sourceID: "zoom", in: namespace))
                                    } label: {
                                        Image(uiImage: uiImage)
                                            .resizable()
                                            .scaledToFill()
                                            .frame(maxWidth: .infinity, maxHeight: 148)
                                            .clipShape(RoundedRectangle(cornerRadius: 10))
                                    }
                                }
                                .frame(maxWidth: .infinity)
                            }
                        } else {
                            HStack(alignment: .center) {
                                Image("RecipeImageDefault")
                                    .resizable()
                                    .scaledToFill()
                                    .frame(maxWidth: .infinity, maxHeight: 148)
                                    .clipShape(RoundedRectangle(cornerRadius: 10))
                            }
                            .frame(maxWidth: .infinity)
                        }
                    }
                    
                    Text(recipe.name)
                        .font(.title.bold())
                        .foregroundStyle(.ameixa)
                    
                    if (!(recipe.needle == 0) || !(recipe.yarn == 0)) {
                        HStack (spacing: 8){
                            if (!(recipe.needle == 0)) {
                                TagRecipeView(tagIcon: "wand.and.outline", tagName: "Agulha de \(recipe.needle.formatted(.number.precision(.fractionLength(1)))) mm")
                            }
                            
                            if (!(recipe.yarn == 0)) {
                                if (!(recipe.yarn == 1)) {
                                    TagRecipeView(tagIcon: "circle", tagName: "\(recipe.yarn) Novelos")
                                }
                                else {
                                    TagRecipeView(tagIcon: "circle", tagName: "\(recipe.yarn) Novelo")
                                }
                            }
                        }
                    }
                }
                
                //para mostrar os pontos
                ScrollView(.horizontal, showsIndicators: false){
                    HStack(alignment: .top){
                        ForEach(stitchs(in: recipe.text)) { stitch in
                            CardRecipeStitchView(stitch: stitch)
                        }
                    }
                }
                
                Text(
                    hightlighTitles(
                        highlightKeywords(recipe.text)
                    )
                )
                .lineSpacing(6)
                .foregroundStyle(.ameixa)
                //                .overlay (
                //                    Image (systemName: "hand. thumbsup-fill")
                //                        .font(.system(size: 200))
                //                        .opacity(0.7)
                //                        .frame(width: 450, height: 300, alignment: .bottom)
                //                        .glassEffect()
                //                )
            }
            .padding(.top, 10)
            .padding(.bottom, 170)
            .padding(.horizontal)
        }
        
        //contador
        .overlay (alignment: .bottom) {
            RecipeCounterView(recipe: recipe)
        }
        //        .sheet(isPresented: $bool, content: {
        //
        //                })
        //                    .padding()
        //                    .frame(width: 40, height: 30)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Menu(content: {
                        if let link = URL(string: recipe.link) {
                            Link(destination: link, label: {
                                Image(systemName: "link")
                                Text("Acessar o tutorial")
                            })
                        }
                        
                        NavigationLink(destination: EditRecipeView(recipe: recipe)) {
                            Image(systemName: "pencil.line")
                            Text("Editar Receita")
                        }
                        
                        Button("Excluir Receita", systemImage: "trash", role: .destructive) {
                            isDeleting = true
                            
                        }
                        
                    }, label: {Image(systemName: "ellipsis")})
                }
            }
            .backgroundCream()
            .alert("Excluir receita", isPresented: $isDeleting, actions: {
                HStack {
                    Button("Cancelar", role: .cancel) {
                    }
                    
                    Button("Excluir", role: .destructive) {
                        modelContext.delete(recipe)
                        dismiss()
                    }
                }
            }, message: {
                Text("Tem certeza que deseja excluir essa receita?")
            })
    }
    
    
    //olha os pontos que estão no texto
    func stitchs(in string: String) -> [Stitch] {
        let allNames = Stitch.allCases.flatMap(\.allNames)
        let filteredNames = allNames.filter { keyword in
            string.range(of: "(\\b\(keyword)\\b|(?<=\\d)\(keyword)\\b)", options: [.regularExpression, .caseInsensitive]) != nil
        }
        let stitchs = filteredNames.compactMap { name in
            Stitch(name: name)
        }
        let uniqueStitchs = OrderedSet(stitchs)
        return Array(uniqueStitchs)
    }
    
    //deixa negrito os pontos
    func highlightKeywords(_ string: String) -> String {
        let keywords = Stitch.allCases.flatMap(\.allNames)
        var result = string
        for keyword in keywords {
            result = result.replacingOccurrences(of: "(\\b\(keyword)\\b|(?<=\\d)\(keyword)\\b)", with: "**\(keyword)**", options: [.regularExpression, .caseInsensitive])
        }
        return result
    }
    
    //deixa negrito os titulos
    func hightlighTitles(_ string: String) -> AttributedString {
        var titles = string.components(separatedBy: .newlines).filter { line in
            line.starts(with: "#")
        }
        titles = titles.map { title in
            String(title.dropFirst())
        }
        
        let string = string.replacingOccurrences(of: "#", with: "")
        
        var attributedString = try! AttributedString(
            markdown: string,
            options: .init(interpretedSyntax: .inlineOnlyPreservingWhitespace)
        )
        
        for title in titles {
            if let range = attributedString.range(of: title) {
                attributedString[range].font = .title2
                attributedString[range].inlinePresentationIntent = .stronglyEmphasized
            }
        }
        
        return attributedString
    }
    
//    func isValidUrl(string: String) -> Bool {
//        let urlRegEx = "^(https?://)?(www\\.)?([-a-z0-9]{1,63}\\.)*?[a-z0-9][-a-z0-9]{0,61}[a-z0-9]\\.[a-z]{2,6}(/[-\\w@\\+\\.~#\\?&/=%]*)?$"
//        let urlTest = NSPredicate(format:"SELF MATCHES %@", urlRegEx)
//        let result = urlTest.evaluate(with: url)
//        return result
//    }
    
}

#Preview {
    RecipeView(
        recipe: Recipe(
            name: "Minha Primeira Receita",
            link: "",
            yarn: 0,
            needle: 0.0,
            text: """
        #Receita
        Faça um nó inicial
        Carreira 1: 6 corr [10]
        Carreira 2: 6 pb [10]
        Carreira 3: 3 [sc, inc] [9]

        #Dicas
        Use # no início da linha para escrever um título e dividir sua receita em partes.

        Você pode escrever os pontos como preferir, por extenso ou em abreviações, em português ou inglês:
        “pb”, “ponto baixo”, “sc” ou “single crochet”.
        Os pontos detectados são automaticamente listados no topo da receita.

        Use o contador de carreiras para acompanhar seu projeto enquanto faz.
        """,
            counter: 0
        )
    )
}

//struct TitleHighlightView: View {
//
//    let string = """
//            #TITLE 1
//            aaaaaaa
//            aaaaaaa
//            aaaaaaa
//
//            #TITLE 2
//            bbbbbbb
//            bbbbbbb
//            bbbbbbb
//            """
//
//    var body: some View {
//        Text(hightlighted())
//    }
//
//}
//
//#Preview {
//    TitleHighlightView()
//}
