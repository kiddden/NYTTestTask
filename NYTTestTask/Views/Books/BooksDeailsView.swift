//
//  BooksDeailsView.swift
//  NYTTestTask
//
//  Created by Eugene Ned on 06.07.2023.
//

import SwiftUI

struct BooksDeailsView: View {
    @Environment(\.presentationMode) private var presentationMode
    
    @Binding var book: Book
    @State private var buyLink: BuyLink?
    
    init(for book: Binding<Book>) {
        self._book = book
    }
    
    var body: some View {
        NavigationView {
            VStack {
                if let link = buyLink {
                    BuyLinkWebView(url: link.url)
                        .navigationTitle(link.name)
                } else {
                    ScrollView {
                        if book.buyLinks.isEmpty {
                            Text(L10n.Books.noBuyLinkFound)
                                .font(.title3)
                                .multilineTextAlignment(.center)
                                .padding()
                        } else {
                            ForEach(book.buyLinks, id:\.self) { link in
                                BuyLinkItem(for: link) { buyLink in
                                    self.buyLink = buyLink
                                }
                            }
                        }
                    }
                    .navigationTitle(L10n.Books.buyLinks)
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    cancelButton
                }
            }
        }
    }
    
    private var cancelButton: Button<Text> {
        Button {
            presentationMode.wrappedValue.dismiss()
        } label: {
            Text("Cancel")
        }
    }
}
