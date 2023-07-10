//
//  L10n.swift
//  NYTTestTask
//
//  Created by Eugene Ned on 10.07.2023.
//

import SwiftUI

internal enum L10n {
    enum Categories {
        
        static var navigationTitle: LocalizedStringKey {
            LocalizedStringKey("categories.navigation-title")
        }
        
        static var publishedDate: LocalizedStringKey {
            LocalizedStringKey("categories.published-date")
        }
        
        static var noCategoryFound: LocalizedStringKey {
            LocalizedStringKey("categories.no-category-found")
        }
    }
    
    enum Books {
        
        static var buyLinks: LocalizedStringKey {
            LocalizedStringKey("books.buy-links")
        }
        
        static var buyButton: LocalizedStringKey {
            LocalizedStringKey("books.buy-button")
        }
        
        static var noBookFound: LocalizedStringKey {
            LocalizedStringKey("books.no-book-found")
        }
        
        static var noBuyLinkFound: LocalizedStringKey {
            LocalizedStringKey("books.no-buy-link-found")
        }
        
        static var authorPrefix: LocalizedStringKey {
            LocalizedStringKey("books.author-prefix")
        }
        
        static var publisherPrefix: LocalizedStringKey {
            LocalizedStringKey("books.publisher-prefix")
        }
    }
}
