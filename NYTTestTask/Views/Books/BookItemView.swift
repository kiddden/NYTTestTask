//
//  BookItemView.swift
//  NYTTestTask
//
//  Created by Eugene Ned on 06.07.2023.
//

import SwiftUI

struct BookItemView: View {
    @Environment(\.colorScheme) private var colorScheme
    
    let book: Book
    
    init(for book: Book) {
        self.book = book
    }
    
    var body: some View {
        HStack {
//            AsyncImage(url: URL(string: book.image))
//                .scaledToFill()
            
            AsyncImage(url: URL(string: book.image),
                       content: { image in
                            image
                                .resizable()
                                .frame(minWidth: UIScreen.main.bounds.width/3, maxWidth: UIScreen.main.bounds.width/3, minHeight: UIScreen.main.bounds.height/6, maxHeight: UIScreen.main.bounds.height/6)
                                .scaledToFit()
                                
            },
                       placeholder: { ProgressView() })
            
            VStack(alignment: .leading) {
                Text(book.title)
                    .multilineTextAlignment(.leading)
                    .font(.headline)
                Text("by \(book.author)")
                    .multilineTextAlignment(.leading)
                    .font(.subheadline)
            }
            Spacer()
            VStack(alignment: .trailing) {
                HStack(spacing: 6) {
                    Text(String(book.rank))
                        .font(.title3)
                    if book.rank >= book.rankLastWeek {
                        Image(systemName: "chevron.up")
                            .resizable()
                            .foregroundColor(.green)
                            .scaledToFit()
                            .frame(width: 14, height: 14)
                            
                    } else {
                        Image(systemName: "chevron.down")
                            .resizable()
                            .foregroundColor(.red)
                            .scaledToFit()
                            .frame(width: 14, height: 14)
                    }
                }
                .padding(6)
                .background(Color(.systemGray5))
                .cornerRadius(10)
                .padding(6)
                
                Spacer()
            }
            .font(.footnote)
            
        }
        .frame(minHeight: UIScreen.main.bounds.height/6, maxHeight: UIScreen.main.bounds.height/6)
        .background(.ultraThinMaterial)
        .cornerRadius(10)
        .padding(.horizontal, 12)
        .shadow(radius: 5, x: 0, y: 0)
        .foregroundColor(colorScheme == .dark ? .white : .black)
    }
}

struct BookItemView_Previews: PreviewProvider {
    static var previews: some View {
        BookItemView(for: Book(rank: 1,
                               rankLastWeek: 3,
                               publisher: "Published",
                               description: "Description",
                               price: "13.15",
                               title: "Title",
                               author: "Author Author",
                               image: "https://storage.googleapis.com/du-prd/books/images/9780670785933.jpg",
                               buyLinks: []))
    }
}
