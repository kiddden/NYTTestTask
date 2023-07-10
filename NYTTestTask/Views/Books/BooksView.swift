//
//  BooksView.swift
//  NYTTestTask
//
//  Created by Eugene Ned on 06.07.2023.
//

import SwiftUI

struct BooksView: View {
    @ObservedObject private var booksVM = BooksViewModel()
    
    let category: Category
    
    init(for category: Category) {
        self.category = category
    }
    
    var body: some View {
        VStack {
            if isLoading {
                loaderView
            } else if booksVM.books.isEmpty {
                Text(L10n.Books.noBookFound)
                    .font(.title3)
                    .multilineTextAlignment(.center)
                    .padding()
            } else {
                booksListView
            }
            
        }
        .navigationTitle(category.name)
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            DispatchQueue.main.async {
                withAnimation { self.isLoading = true }
                booksVM.fetchBooks(for: category) { error in
                    withAnimation { self.isLoading = false }
                    if let error = error {
                        print(error)
                    }
                }
            }
        }
        .sheet(isPresented: $showBookDetailsView) {
            BooksDeailsView(for: $chosenBook)
        }
    }
    
    private var loaderView: some View {
        ProgressView().scaleEffect(2)
            .tint(.blue)
    }
    
    @State private var isLoading = true
    @State private var showBookDetailsView = false
    @State private var chosenBook: Book = Book()
    
    private var booksListView: some View {
        ScrollView {
            VStack(spacing: 12) {
                ForEach(booksVM.books, id: \.id) { book in
                    Button {
                        self.chosenBook = book
                        self.showBookDetailsView = true
                    } label: {
                        BookItemView(for: book)
                    }
                }
            }
        }
        .background(Color(.secondarySystemBackground))
        .refreshable {
            DispatchQueue.main.async {
                self.booksVM.fetchBooks(for: category) { error in
                    if let error = error {
                        print(error.localizedDescription)
                    }
                }
            }
        }
    }
}

