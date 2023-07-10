//
//  ContentView.swift
//  NYTTestTask
//
//  Created by Eugene Ned on 06.07.2023.
//

import SwiftUI

struct CategoriesView: View {
    @ObservedObject private var categoriesVM = CategoriesViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                if isLoading {
                    loaderView
                } else if categoriesVM.categories.isEmpty {
                        Text(L10n.Categories.noCategoryFound)
                            .font(.title3)
                            .multilineTextAlignment(.center)
                            .padding()
                } else {
                    categoriesListView
                }
            }
            .navigationTitle(L10n.Categories.navigationTitle)
            .navigationBarTitleDisplayMode(.inline)
        }
        .onAppear {
            DispatchQueue.main.async {
                withAnimation { self.isLoading = true }
                categoriesVM.fetchCategories { error in
                    withAnimation { self.isLoading = false }
                    if let error = error {
                        
                        print(error)
                    }
                }
            }
        }
    }
    
    private var loaderView: some View {
        ProgressView().scaleEffect(2)
            .tint(.blue)
    }
    
    @State private var isLoading = true
    
    private var categoriesListView: some View {
        ScrollView {
            VStack {
                ForEach(categoriesVM.categories, id: \.id) { category in
                    NavigationLink {
                        BooksView(for: category)
                    } label: {
                        CategoryItemView(name: category.name, date: category.publishedDate)
                    }
                }
            }
        }
        .background(Color(.secondarySystemBackground))
        .refreshable {
            DispatchQueue.main.async {
                self.categoriesVM.fetchCategories { error in
                    if let error = error {
                        print(error)
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        CategoriesView()
    }
}
