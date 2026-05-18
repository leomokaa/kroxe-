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
    
    var body: some View {
        NavigationStack {
            ZStack {
                ScrollView(showsIndicators: false){
                    if horizontalSizeClass == .compact {
                        VStack (spacing: 14) {
                            recipiesItems
                        }
                        .padding(.horizontal)
                        .padding(.vertical, 20)
                    } else {
                        LazyVGrid(columns: [GridItem(spacing: 14), GridItem()], spacing: 14) {
                            recipiesItems
                        }
                        .padding(.horizontal)
                        .padding(.vertical, 20)
                    }
                    
                }
                .opacity(recipes.isEmpty ? 0 : 1)
                
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
    
    var recipiesItems: some View {
            //                Text("Suas receitas de crochê em um só lugar")
            //                    .font(.subheadline)
            //                    .foregroundColor(.secondary)
            ForEach(recipes.enumerated(), id: \.offset) { index, recipe in
                CardRecipeView(recipe: recipe)
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
