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
            if booksVM.isLoading {
                loaderView
            } else {
                booksListView
            }
        }
        .navigationTitle(category.name)
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            DispatchQueue.main.async {
                booksVM.fetchBooks(for: category) { error in
                    if let error = error {
                        print(error)
                    }
                }
            }
        }
        .sheet(isPresented: $showBookDetailsView) {
            if let book = book {
                BooksDeailsView(for: book)
            }
        }
    }
    
    private var loaderView: some View {
        ProgressView().scaleEffect(2)
            .tint(.blue)
    }
    @State private var showBookDetailsView = false
    @State private var book: Book?
    
    private var booksListView: some View {
        ScrollView {
            VStack(spacing: 12) {
                ForEach(booksVM.books, id: \.id) { book in
                    if booksVM.books.isEmpty {
                        Text("No category found, check your internet connection and try again!")
                            .font(.title3)
                            .multilineTextAlignment(.center)
                            .padding()
                    } else {
                        BookItemView(for: book)
                            .onTapGesture {
                                self.book = book
                                showBookDetailsView = true
                            }
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

//struct BooksView_Previews: PreviewProvider {
//    static var previews: some View {
//        BooksView(for: Category(name: "Test", nameEncoded: "test-1", publishedDate: "2012-08-12"))
//    }
//}
