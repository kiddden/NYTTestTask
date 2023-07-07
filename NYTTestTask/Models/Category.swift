//
//  Category.swift
//  NYTTestTask
//
//  Created by Eugene Ned on 06.07.2023.
//

import Foundation
import RealmSwift

final class Category: Object, ObjectKeyIdentifiable, Codable {
    @Persisted(primaryKey: true) var _id: ObjectId
    @Persisted var name: String
    @Persisted var nameEncoded: String
    @Persisted var publishedDate: String
    
    enum CodingKeys: String, CodingKey {
        case name = "display_name"
        case nameEncoded = "list_name_encoded"
        case publishedDate = "newest_published_date"
    }
}
