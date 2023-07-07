//
//  BooksDeailsView.swift
//  NYTTestTask
//
//  Created by Eugene Ned on 06.07.2023.
//

import SwiftUI

struct BooksDeailsView: View {
    let book: Book
    
    init(for book: Book) {
        self.book = book
    }
    
    var body: some View {
        Text("BooksDeailsView")
    }
}

//struct BooksDeailsView_Previews: PreviewProvider {
//    static var previews: some View {
//        BooksDeailsView(for: Book(rank: 1,
//                                  rankLastWeek: 3,
//                                  publisher: "Published",
//                                  description: "Description",
//                                  price: "13.15",
//                                  title: "Title",
//                                  author: "Author Author",
//                                  image: "https://storage.googleapis.com/du-prd/books/images/9780670785933.jpg",
//                                  buyLinks: []))
//    }
//}
