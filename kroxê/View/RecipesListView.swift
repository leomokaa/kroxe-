//
//  RecipesListView.swift
//  kroxê
//
//  Created by User on 27/04/26.
//

import SwiftUI
import SwiftData
import PhotosUI

struct RecipesListView: View {
    
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext
    
    @Query(sort: \Recipe.timestamp, order: .reverse) var recipes: [Recipe]
    
    @State var presentSheet = false
    @State var presentEditSheet: Bool = false
    @State private var isDeleting: Bool = false
    @State private var recipeEdit: Recipe?
    @State private var recipeDelete: Recipe?
    
    var body: some View {
        NavigationStack {
            ZStack {
                //se for a tela for horizontalmente mais estreita, vai ser a visualização de lista
                if horizontalSizeClass == .compact {
                    iphoneItems
                        .opacity(recipes.isEmpty ? 0 : 1)
                    
                } else {
                    //se não for estreita, vai ser visualização em grid
                    ipadItems
                        .opacity(recipes.isEmpty ? 0 : 1)
                        .padding(.horizontal)
                        .padding(.vertical, 20)
                        .listRowBackground(EmptyView())
                        .listRowSeparator(.hidden)
                        .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                }
                
                //se a lista de receitas for vazia, tem essa visualização
                emptyStateList
                    .opacity(recipes.isEmpty ? 1 : 0)
                
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.top, -6)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button ("", systemImage: "plus") {
                        presentSheet.toggle()
                    }
                    .buttonStyle(.borderedProminent)
                    .accessibilityLabel(Text("Adicionar receita"))
                    .sheet(isPresented: $presentSheet) {
                        NavigationStack {
                            CreateRecipeView()
                        }
                        .presentationSizing(.page)
                    }
                }
            }
            .navigationTitle("Receitas")
            .navigationTitleColor(.ameixa)
            .toolbarTitleDisplayMode(.inlineLarge)
            .backgroundCream()
            .accessibilityHidden(presentSheet)
        }
        
        //aqui é para contornar a adição constante de novas "primeira receita" toda vez ao instalar
        //então ao perceber que as receitas foram alteradas, ele busca e deleta as duplicadas
        .onChange(of: recipes){
            removeDuplicates(recipes: recipes)
        }
        
    }
    
    func removeDuplicates(recipes: [Recipe]) {
        if recipes.count > 1 {
            if recipes.count(where: {$0.isFirstRecipe}) >= 2{
                if let deletFirstRecipe = recipes.first(where: {$0.isFirstRecipe == true}) {
                    modelContext.delete(deletFirstRecipe)
                }
                
                return
            }
        }
    }
    
    var ipadItems: some View {
        ScrollView (showsIndicators: false) {
            LazyVGrid(columns: [GridItem(spacing: 14), GridItem()], spacing: 14) {
                ForEach(recipes.enumerated(), id: \.offset) { index, recipe in
                    CardRecipeView(recipe: recipe)
                        .listRowBackground(EmptyView())
                        .listRowSeparator(.hidden)
                        .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                        .navigationLinkIndicatorVisibility(.hidden)
                    
                    //aqui substitui o swipe no ipad por um outro gesture de pressionar
                        .contextMenu(menuItems: {
                            if let link = URL(string: recipe.link) {
                                Link(destination: link, label: {
                                    Image(systemName: "link")
                                    Text("Acessar o tutorial")})
                            }
                            
                            Button ("Editar Receita", systemImage: "pencil") {
                                recipeEdit = recipe
                            }
                            .buttonStyle(.borderedProminent)
                            
                            Button("Excluir Receita", systemImage: "trash", role: .destructive) {
                                recipeDelete = recipe
                                isDeleting.toggle()
                            }
                        })
                    
                        .sheet(item: $recipeEdit) { recipe in
                            NavigationStack {
                                EditRecipeView(recipe: recipe)
                            }
                            .presentationSizing(.page)
                        }
                    
                        .alert("Excluir receita", isPresented: $isDeleting, actions: {
                            HStack {
                                Button("Cancelar", role: .cancel) {
                                }
                                
                                Button("Excluir", role: .destructive) {
                                    if let recipeDelete = recipeDelete {
                                        modelContext.delete(recipeDelete)
                                        try? modelContext.save()
                                    }
                                }
                            }
                        }, message: {
                            Text("Tem certeza que deseja excluir essa receita?")
                        })
                }
            }
        }
    }
    
    var iphoneItems: some View {
        List{
            ForEach(recipes.enumerated(), id: \.offset) { index, recipe in
                CardRecipeView(recipe: recipe)
                    .listRowBackground(EmptyView())
                    .listRowSeparator(.hidden)
                    .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                    .navigationLinkIndicatorVisibility(.hidden)
                    .padding (.vertical, 7)
                    .padding (.horizontal)
                
                    .swipeActions {
                        Button("Excluir", systemImage: "trash") {
                            recipeDelete = recipe
                            isDeleting.toggle()
                        }
                        .tint(Color.red)
                        
                        Button("Editar", systemImage: "pencil") {
                            recipeEdit = recipe
                        }
                        .tint(.accent)
                        
                        if let link = URL(string: recipe.link) {
                            Link(destination: link, label: {
                                Image(systemName: "link")
                                Text("Tutorial")})
                            .tint(Color.lavanda)
                        }
                    }
                
                    .sheet(item: $recipeEdit) { recipe in
                        NavigationStack {
                            EditRecipeView(recipe: recipe)
                        }
                        .presentationSizing(.page)
                    }
                
                    .alert("Excluir receita", isPresented: $isDeleting, actions: {
                        HStack {
                            Button("Cancelar", role: .cancel) {
                            }
                            
                            Button("Excluir", role: .destructive) {
                                if let recipeDelete = recipeDelete {
                                    modelContext.delete(recipeDelete)
                                    try? modelContext.save()
                                }
                            }
                        }
                    }, message: {
                        Text("Tem certeza que deseja excluir essa receita?")
                    })
            }
        }
        .listStyle(.plain)
        .contentMargins(.vertical, 20)
        .scrollIndicators(.hidden)
    }
    
    var emptyStateList: some View {
        NoRecipeView()
    }
}

#Preview {
    RecipesListView()
        .modelContainer(PreviewSetup.previewRecepiesList)
}
