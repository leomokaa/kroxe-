//
//  RecipesListView.swift
//  kroxê
//
//  Created by User on 27/04/26.
//

import SwiftUI
import SwiftData

struct RecipesListView: View {
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \Recipe.name) var recipes: [Recipe]
    //    @State var searchResults: [Recipe] = []
    //    @State var searchQuery: String = ""
    
    //    var isSearching: Bool {
    //        return !searchQuery.isEmpty
    //    }
    //
    //    private func fetchSearchResults(for query: String) {
    //        searchResults = recipes.filter { Recipe in
    //            Recipe.name
    //                .lowercased()
    //                .contains(searchQuery)
    //        }
    //    }
    
//    @State var toolbarVisibility: Visibility = .automatic
    
    var body: some View {
        NavigationStack {
            ZStack {
                recepiesList
                    .opacity(recipes.isEmpty ? 0 : 1)
                
                emptyStateList
                    .opacity(recipes.isEmpty ? 1 : 0)
                
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal)
            .padding(.top, -6)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    NavigationLink(destination: CreateRecipeView()) {
                        Image(systemName: "plus")
                    }
                    .buttonStyle(.borderedProminent)
                }
            }
            .navigationTitle("Receitas")
            .navigationTitleColor(.ameixa)
            .toolbarTitleDisplayMode(.inlineLarge)
            .backgroundCream()
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
        
        
        
        //            .searchable(
        //                text: $searchQuery,
        //                placement: .toolbar,
        //                prompt: "Pesquise Receitas"
        //            )
        //            .searchToolbarBehavior(.minimize)
        
    }
    
    var recepiesList: some View {
        ScrollView(showsIndicators: false){
//                Text("Suas receitas de crochê em um só lugar")
//                    .font(.subheadline)
//                    .foregroundColor(.secondary)
                    VStack (spacing: 14) {
                        ForEach(recipes.enumerated(), id: \.offset) { index, recipe in
                            CardRecipeView(recipe: recipe)
                        }
                    }
            
            .padding(.vertical, 20)
       }
//        .scrollBounceBehavior()
    }
    
    var emptyStateList: some View {
        NoRecipeView()
    }
}

#Preview {
    RecipesListView()
        .modelContainer(PreviewSetup.previewRecepiesList)
}
