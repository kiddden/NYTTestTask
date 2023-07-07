//
//  Book.swift
//  NYTTestTask
//
//  Created by Eugene Ned on 06.07.2023.
//

import Foundation
import RealmSwift

final class Book: Object, ObjectKeyIdentifiable, Codable {
    @Persisted(primaryKey: true) var id: String
    @Persisted var categoryID: String
    @Persisted var rank: Int // TODO: rank change
    @Persisted var rankLastWeek: Int
    @Persisted var publisher: String
    @Persisted var bookDescription: String
    @Persisted var price: String
    @Persisted var title: String
    @Persisted var author: String
    @Persisted var image: String
    @Persisted var buyLinks: RealmSwift.List<BuyLink>
    
    enum CodingKeys: String, CodingKey {
        case id = "primary_isbn10"
        case rank
        case rankLastWeek = "rank_last_week"
        case publisher
        case bookDescription = "description"
        case price
        case title
        case author
        case image = "book_image"
        case buyLinks = "buy_links"
    }
}

final class BuyLink: Object, ObjectKeyIdentifiable, Codable {
    @Persisted var name: String
    @Persisted var url: String
}
