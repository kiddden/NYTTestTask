//
//  NYTResponse.swift
//  NYTTestTask
//
//  Created by Eugene Ned on 06.07.2023.
//

import Foundation

struct TopLevelNYTResponse<T: Codable>: Codable {
    let results: T
}

struct BottomLevelNYTResponse: Codable {
    let books: [Book]
}

