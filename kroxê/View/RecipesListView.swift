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
    
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \Recipe.name) var recipes: [Recipe]
    @State var PresentSheet = false
     
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
                    Button ("", systemImage: "plus") {
                        PresentSheet.toggle()
                    }
                    .buttonStyle(.borderedProminent)
                    .sheet(isPresented: $PresentSheet) {
                        NavigationStack {
                            CreateRecipeView()
                        }
                    }
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
