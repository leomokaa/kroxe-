//
//  RecipeView.swift
//  kroxê
//
//  Created by User on 28/04/26.
//

import SwiftUI
import OrderedCollections

extension String {
    func highlighted(keywords: [String]) -> String {
        var result: String = self
        for keyword in keywords {
            result = result.replacingOccurrences(of: keyword, with: " **\(keyword.dropFirst())**")
        }
        return result
    }
}

struct RecipeView: View {
    var recipe: Recipe
    @State var bool: Bool = true
   
    var body: some View {
        ScrollView(showsIndicators: false){
            VStack(alignment: .leading, spacing: 20) {
                VStack(alignment: .leading, spacing: 12) {
                    VStack{
                        if let data = recipe.photo {
                            if let uiImage = UIImage(data: data) {
                                HStack(alignment: .center){
                                    Image(uiImage: uiImage)
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 370, height: 148)
                                        .clipShape(RoundedRectangle(cornerRadius: 10))
                                }
                                .frame(maxWidth: .infinity)
                            }
                        } else {
                            HStack(alignment: .center) {
                                Image("RecipeImageDefault")
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 370, height: 148)
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
                                TagRecipeView(tagIcon: "wand.and.outline", tagName: "Agulha: \(recipe.needle.formatted(.number.precision(.fractionLength(1)))) mm")
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
                .foregroundStyle(.ameixa)
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
                }, label: {Image(systemName: "ellipsis")})
            }
        }
        .backgroundCream()
    }
    
    
    //olha os pontos que estão no texto
    func stitchs(in string: String) -> [Stitch] {
        let allNames = Stitch.allCases.flatMap(\.allNames)
        let filteredNames = allNames.filter { name in
            string.lowercased().contains(name)
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
            result = result.replacingOccurrences(of: keyword, with: " **\(keyword.dropFirst())**", options: .caseInsensitive)
        }
        //identar etapas
        //        result = result
        //            .components(separatedBy: .newlines)
        //            .map { line in
        //                if line.starts(with: "#") {
        //                    return line
        //                } else {
        //                    return "   " + line
        //                }
        //            }
        //            .joined(separator: "\n")
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
    
}

#Preview {
    RecipeView(
        recipe: Recipe(
            name: "Coelhinho",
            link: "link.com",
            yarn: 1,
            needle: 0.1,
            text: """
            #titulo
            Rnd 1. 7 sc in Magic Ring (7)
            Rnd 2. 7 inc (14)
            Rnd 3. (1 single crochet, inc) x 7 (21)
            Rnd 4. (2 sc, inc) x 7 (28)
            Rnd 5. (3 sc, inc) x 7 (35)
            Rnd 6 - 13. sc in each (35)
            Add safety eyes between rounds 10 and 11, 7 st apart
            Stuff
            
            #titulo 2
            Rnd 14. (3 sc, dec) x 7 (28)
            Rnd 15. (2 sc, dec) x 7 (21)
            Rnd 16. (1 sc, dec) x 7 (14)
            Stuff some more
            Rnd 17. 14 dec (7)
            sl st and f.o.
            Embroider a nose between rounds 10 and 11, mouth from 11  to 12
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
