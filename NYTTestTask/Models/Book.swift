//
//  Book.swift
//  NYTTestTask
//
//  Created by Eugene Ned on 06.07.2023.
//

import Foundation

struct Book: Codable, Identifiable {
    let id = UUID().uuidString
    let rank: Int // TODO: rank change
    let rankLastWeek: Int
    let publisher: String
    let description: String
    let price: String
    let title: String
    let author: String
    let image: String
    let buyLinks: [BuyLink]
    
    enum CodingKeys: String, CodingKey {
        case rank
        case rankLastWeek = "rank_last_week"
        case publisher
        case description
        case price
        case title
        case author
        case image = "book_image"
        case buyLinks = "buy_links"
    }
}

struct BuyLink: Codable {
    let name: String
    let url: String
}
