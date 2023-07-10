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
    
    let action: (Book) -> ()
    
    @State private var image: UIImage?
    
    init(for book: Book, action: @escaping (Book) -> ()) {
        self.book = book
        self.action = action
    }
    
    var body: some View {
        HStack(spacing: 0) {
            bookImageView
            VStack {
                HStack {
                    bookInfoView
                    Spacer()
                    rankView
                }
                Divider()
                Text(book.bookDescription)
                    .multilineTextAlignment(.leading)
                    .font(.footnote)
                
                Spacer()
            }
            .padding(Constants.Sizes.padding)
        }
        .frame(minHeight: Constants.Sizes.cardMinHeight, maxHeight: Constants.Sizes.cardMaxHeight)
        .background(.ultraThinMaterial)
        .cornerRadius(Constants.Sizes.cornerRadius)
        .padding(.horizontal, Constants.Sizes.padding*2)
        .shadow(radius: 5, x: 0, y: 0)
        .foregroundColor(colorScheme == .dark ? .white : .black)
        .onAppear {
            NYTAPIService.shared.downloadImage(from: book.image) { downloadedImage in
                self.image = downloadedImage
            }
        }
        .onTapGesture {
            action(book)
        }
    }
    
    @ViewBuilder
    private var bookImageView: some View {
        if let image = image {
            Image(uiImage: image)
                .resizable()
                .frame(minWidth: Constants.Sizes.bookImageWidth,
                       maxWidth: Constants.Sizes.bookImageWidth,
                       minHeight: Constants.Sizes.bookImageHeight,
                       maxHeight: Constants.Sizes.bookImageHeight)
                .scaledToFit()
                .cornerRadius(Constants.Sizes.cornerRadius)
        } else {
            ProgressView()
                .frame(minWidth: Constants.Sizes.bookImageWidth,
                       maxWidth: Constants.Sizes.bookImageWidth,
                       minHeight: Constants.Sizes.bookImageHeight,
                       maxHeight: Constants.Sizes.bookImageHeight)
        }
    }
    
    private var bookInfoView: some View {
        VStack(alignment: .leading) {
            Text(book.title)
                .multilineTextAlignment(.leading)
                .font(.headline)
            
            Text(L10n.Books.authorPrefix) + Text(book.author)
            
            Text(L10n.Books.publisherPrefix) + Text(book.publisher)
        }
        .multilineTextAlignment(.leading)
        .font(.subheadline)
    }
    
    private var rankView: some View {
        VStack {
            HStack(spacing: Constants.Sizes.padding) {
                Text(String(book.rank))
                    .font(.title3)
                Image(systemName: book.rank >= book.rankLastWeek ? Constants.Images.chevronUp : Constants.Images.chevronDown)
                    .resizable()
                    .foregroundColor(book.rank >= book.rankLastWeek ? .green : .red)
                    .scaledToFit()
                    .frame(width: Constants.Sizes.chevronSize, height: Constants.Sizes.chevronSize)
            }
            .padding(Constants.Sizes.padding)
            .background(Color(.systemGray4))
            .cornerRadius(Constants.Sizes.cornerRadius)
            .padding(Constants.Sizes.padding)
            
            Spacer()
        }
    }
    
    // MARK: - Constants
    enum Constants {
        enum Sizes {
            static let cardMinHeight: CGFloat = UIScreen.main.bounds.height/5
            static let cardMaxHeight: CGFloat = UIScreen.main.bounds.height/5
            static let cornerRadius: CGFloat = 10
            static let chevronSize: CGFloat = 14
            static let padding: CGFloat = 6
            static let bookImageWidth: CGFloat = UIScreen.main.bounds.width/3
            static let bookImageHeight: CGFloat = UIScreen.main.bounds.height/5
        }
        
        enum Images {
            static let chevronUp = "chevron.up"
            static let chevronDown = "chevron.down"
        }
    }
}
