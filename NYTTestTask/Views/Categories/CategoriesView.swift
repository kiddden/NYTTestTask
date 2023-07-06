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
                if categoriesVM.isLoading {
                    loaderView
                } else {
                    categoriesListView
                }
            }
            .navigationTitle("NYT Categories")
            .navigationBarTitleDisplayMode(.inline)
        }
        .onAppear {
            DispatchQueue.main.async {
                categoriesVM.fetchCategories { error in
                    if let error = error {
                        
                    }
                }
            }
        }
    }
    
    private var loaderView: some View {
        ProgressView().scaleEffect(2)
            .tint(.blue)
    }
    
    private var categoriesListView: some View {
        ScrollView {
            VStack(spacing: 12) {
                ForEach(categoriesVM.categories, id: \.id) { category in
                    if categoriesVM.categories.isEmpty {
                        Text("No category found, check your internet connection and try again!")
                            .font(.title3)
                            .multilineTextAlignment(.center)
                            .padding()
                    } else {
                        NavigationLink {
                            BooksView(for: category)
                        } label: {
                            CategoryItemView(name: category.name, date: category.publishedDate)
                        }
                    }
                }
            }
        }
        .background(Color(.secondarySystemBackground))
        .refreshable {
            DispatchQueue.main.async {
                self.categoriesVM.fetchCategories { error in
                    if let error = error {
                        
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
