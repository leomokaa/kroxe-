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
    @Query(sort: \Recipe.name) var recipes: [Recipe] = [
        Recipe(name: "Coelhinho", link: "", yarn: 2, needle: 3.5, text: "lalala"),
        Recipe(name: "Estrelinha", link: "blablbla", yarn: 1, needle: 2.0, text: "fafafa")
    ]
    @State var searchResults: [Recipe] = []
    @State var searchQuery: String = ""
    
    var isSearching: Bool {
        return !searchQuery.isEmpty
    }
    
    private func fetchSearchResults(for query: String) {
        searchResults = recipes.filter { Recipe in
            Recipe.name
                .lowercased()
                .contains(searchQuery)
        }
    }
    
    var body: some View {
        NavigationStack {
            VStack (alignment: .leading, spacing: 20) {
                if isSearching {
                    ForEach($searchResults) { RecipeSearched in
                        VStack {
                            //                            Text("Suas receitas de crochê em um só lugar")
                            //                                .font(.subheadline)
                            //                                .foregroundColor(.secondary)
                            VStack (spacing: 14) {
                                ForEach(recipes.enumerated(), id: \.offset) { index, recipe in
                                    CardRecipeView(recipe: recipe)
                                }
                            }
                            Spacer()
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal)
                        .padding(.top, -6)
                        .navigationTitle("Receitas")
                        .backgroundCream()
                    }
                }
                else {
                    VStack {
                        Text("Suas receitas de crochê em um só lugar")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                        ScrollView{
                            VStack (spacing: 14) {
                                ForEach(recipes.enumerated(), id: \.offset) { index, recipe in
                                    CardRecipeView(recipe: recipe)
                                }
                            }
                        }
                        Spacer()
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                    .padding(.top, -6)
                    .navigationTitle("Receitas")
                    .backgroundCream()
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    NavigationLink(destination: CreateRecipeView()) {
                        Button("", systemImage: "plus") {
                        }
                    }
                }
            }
            //            .searchable(
            //                text: $searchQuery,
            //                placement: .toolbar,
            //                prompt: "Pesquise Receitas"
            //            )
            //            .searchToolbarBehavior(.minimize)
        }
    }
}

#Preview {
    RecipesListView()
        .modelContainer(PreviewSetup.previewRecepiesList)
}
