//
//  Category.swift
//  NYTTestTask
//
//  Created by Eugene Ned on 06.07.2023.
//

import Foundation

struct Category: Codable, Identifiable {
    var id = UUID().uuidString
    let name: String
    let nameEncoded: String
    let publishedDate: String
    
    enum CodingKeys: String, CodingKey {
        case name = "display_name"
        case nameEncoded = "list_name_encoded"
        case publishedDate = "newest_published_date"
    }
}
