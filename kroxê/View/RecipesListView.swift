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
    @State var PresentSheet = false
    @State var PresentEditSheet: Bool = false
    @State private var isDeleting: Bool = false
    //  @State var recipe: Recipe
    
    var body: some View {
        NavigationStack {
            ZStack {
                //                ScrollView(showsIndicators: false){
                if horizontalSizeClass == .compact {
                    VStack (spacing: 14) {
                        iphoneItems
                    }
                    .opacity(recipes.isEmpty ? 0 : 1)
                    .padding(.horizontal)
                    .padding(.vertical, 20)
                    
                } else {
                    //                        LazyVGrid(columns: [GridItem(spacing: 14), GridItem()], spacing: 14) {
                    ipadItems
                    //                        }
                        .opacity(recipes.isEmpty ? 0 : 1)
                        .padding(.horizontal)
                        .padding(.vertical, 20)
                        .listRowBackground(EmptyView())
                        .listRowSeparator(.hidden)
                        .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                }
                
                //                }
                //                .opacity(recipes.isEmpty ? 0 : 1)
                
                emptyStateList
                    .opacity(recipes.isEmpty ? 1 : 0)
                
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.top, -6)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button ("", systemImage: "plus") {
                        PresentSheet.toggle()
                    }
                    .buttonStyle(.borderedProminent)
                    .accessibilityLabel(Text("Adicionar receita"))
                    .sheet(isPresented: $PresentSheet) {
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
            .accessibilityHidden(PresentSheet)
            //            .toolbarVisibility(toolbarVisibility, for: .tabBar)
            //            .onAppear {
            //                withAnimation {
            //                    toolbarVisibility = .visible
            //                }
            //            }
            //            .onDisappear {
            //                withAnimation {
            //                    toolbarVisibility = .hidden
            //                }
            //            }
        }
        .onChange(of: recipes){
            removeDuplicates(recipes: recipes)
        }
        
        
        //            .searchable(
        //                text: $searchQuery,
        //                placement: .toolbar,
        //                prompt: "Pesquise Receitas"
        //            )
        //            .searchToolbarBehavior(.minimize)
        
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
        //                Text("Suas receitas de crochê em um só lugar")
        //                    .font(.subheadline)
        //                    .foregroundColor(.secondary)
        ScrollView (showsIndicators: false) {
            LazyVGrid(columns: [GridItem(spacing: 14), GridItem()], spacing: 14) {
                ForEach(recipes.enumerated(), id: \.offset) { index, recipe in
                    CardRecipeView(recipe: recipe)
                        .listRowBackground(EmptyView())
                        .listRowSeparator(.hidden)
                        .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                        .navigationLinkIndicatorVisibility(.hidden)
//                        .sheet(isPresented: $PresentEditSheet) {
//                            NavigationStack {
//                                EditRecipeView(recipe: recipe)
//                            }
//                            .presentationSizing(.page)
//                        }
//                        .alert("Excluir receita", isPresented: $isDeleting, actions: {
//                            HStack {
//                                Button("Cancelar", role: .cancel) {
//                                }
//                                
//                                Button("Excluir", role: .destructive) {
//                                    modelContext.delete(recipe)
//                                    dismiss()
//                                }
//                            }
//                        }, message: {
//                            Text("Tem certeza que deseja excluir essa receita?")
//                        })
//                        .contextMenu(menuItems: {
//                            if let link = URL(string: recipe.link) {
//                                Link(destination: link, label: {
//                                    Image(systemName: "link")
//                                    Text("Acessar o tutorial")})
//                            }
//                            
//                            Button ("Editar Receita", systemImage: "pencil.line") {
//                                PresentEditSheet.toggle()
//                            }
//                            .buttonStyle(.borderedProminent)
//                            
//                            Button("Excluir Receita", systemImage: "trash", role: .destructive) {
//                                isDeleting = true
//                            }
//                        })
                }
            }
        }
        //        .scrollBounceBehavior()
    }
    
    var iphoneItems: some View {
        List{
    
//    var recipiesItems: some View {
            //                Text("Suas receitas de crochê em um só lugar")
            //                    .font(.subheadline)
            //                    .foregroundColor(.secondary)
            ForEach(recipes.enumerated(), id: \.offset) { index, recipe in
                CardRecipeView(recipe: recipe)
                    .listRowBackground(EmptyView())
                    .listRowSeparator(.hidden)
                    .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                    .navigationLinkIndicatorVisibility(.hidden)
                    .padding (.vertical, 7)
//                    .sheet(isPresented: $PresentEditSheet) {
//                        NavigationStack {
//                            EditRecipeView(recipe: recipe)
//                        }
//                        .presentationSizing(.page)
//                    }
//                    .alert("Excluir receita", isPresented: $isDeleting, actions: {
//                        HStack {
//                            Button("Cancelar", role: .cancel) {
//                            }
//                            
//                            Button("Excluir", role: .destructive) {
//                                modelContext.delete(recipe)
//                                dismiss()
//                            }
//                        }
//                    }, message: {
//                        Text("Tem certeza que deseja excluir essa receita?")
//                    })
//                    .contextMenu(menuItems: {
//                        if let link = URL(string: recipe.link) {
//                            Link(destination: link, label: {
//                                Image(systemName: "link")
//                                Text("Acessar o tutorial")})
//                        }
//                        
//                        Button ("Editar Receita", systemImage: "pencil.line") {
//                            PresentEditSheet.toggle()
//                        }
//                        .buttonStyle(.borderedProminent)
//                        
//                        Button("Excluir Receita", systemImage: "trash", role: .destructive) {
//                            isDeleting = true
//                        }
//                    })
//
                
                
                
                
//                    .sheet(isPresented: $PresentEditSheet) {
//                        NavigationStack {
//                             EditRecipeView(recipe: recipe)
//                        }
//                        .presentationSizing(.page)
//                    }
//                    .alert("Excluir receita", isPresented: $isDeleting, actions: {
//                        HStack {
//                            Button("Cancelar", role: .cancel) {
//                            }
//                            
//                            Button("Excluir", role: .destructive) {
//                                modelContext.delete(recipe)
//                                dismiss()
//                            }
//                        }
//                    }, message: {
//                        Text("Tem certeza que deseja excluir essa receita?")
//                    })
//                    .swipeActions(edge: .trailing, allowsFullSwipe: false) {
//                        Button(role: .destructive) {
//                            isDeleting = true
//                        } label: {
//                            Label("Excluir", systemImage: "trash")
//                        }
//                        
//                        Button {
//                            PresentEditSheet.toggle()
//                        } label: {
//                            Label("Editar", systemImage: "pencil")
//                        }
//                        .tint(.accent)
//                    }
//                    
//                    
//                    .swipeActions(edge: .leading, allowsFullSwipe: false) {
//                        if let link = URL(string: recipe.link) {
//                            Link(destination: link, label: {
//                                Image(systemName: "link")
//                                Text("Acessar o tutorial")})
//                        }
//                    }
            }
        }
        .listStyle(.plain)
        // .opacity(albumsModel.isEmpty ? 0 : 1)
    }
    
    var emptyStateList: some View {
        NoRecipeView()
    }
}

#Preview {
    RecipesListView()
        .modelContainer(PreviewSetup.previewRecepiesList)
}
