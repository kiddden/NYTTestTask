//
//  NYTAPIService.swift
//  NYTTestTask
//
//  Created by Eugene Ned on 06.07.2023.
//

import Foundation
import RealmSwift
import UIKit

class NYTAPIService {
    
    static let shared = NYTAPIService()
    
    private let imageCache = ImageCache()
    
    private let baseURL = "https://api.nytimes.com/svc/books/v3/"
    private let APIKey = "h0Xuhy01G7MA8YlSUd9L5WhMoiySphvb"
    
    private init() { }
    
    func getCategories(completion: @escaping(Result<[Category], NYTError>) -> Void) {
        let endpoint = baseURL + "lists/names.json?api-key=\(APIKey)"
        
        guard let url = URL(string: endpoint) else {
            completion(.failure(.invalidEndpoint))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let _ = error {
                completion(.failure(.unableToComplete))
                return
            }
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completion(.failure(.invalidResponse))
                return
            }
            guard let data = data else {
                completion(.failure(.invalidData))
                return
            }
            DispatchQueue.main.async {
                do {
                    let decoder = JSONDecoder()
                    let response = try decoder.decode(TopLevelNYTResponse<[Category]>.self, from: data)
                    let categories = response.results.compactMap {
                        try? $0._id = ObjectId(string: $0.nameEncoded)
                        return $0
                    }
                    
                    let realm = try Realm()
                    try realm.write {
                        realm.add(categories, update: .all)
                    }
                    
                    completion(.success(categories))
                } catch {
                    completion(.failure(.errorDecoding))
                }
            }
            
        }
        task.resume()
    }
    
    func getBooks(for category: Category, completion: @escaping(Result<[Book], NYTError>) -> Void) {
        let endpoint = baseURL + "lists/\(category.publishedDate)/\(category.nameEncoded).json?api-key=\(APIKey)"
        
        guard let url = URL(string: endpoint) else {
            completion(.failure(.invalidEndpoint))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let _ = error {
                completion(.failure(.unableToComplete))
                return
            }
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completion(.failure(.invalidResponse))
                return
            }
            guard let data = data else {
                completion(.failure(.invalidData))
                return
            }
            DispatchQueue.main.async {
                do {
                    let decoder = JSONDecoder()
                    let response = try decoder.decode(TopLevelNYTResponse<BottomLevelNYTResponse>.self, from: data)
                    let books = response.results.books
                    books.forEach { $0.categoryID = category._id.stringValue }
                    
                    let realm = try Realm()
                    try realm.write {
                        realm.add(books, update: .all)
                    }
                    
                    completion(.success(books))
                } catch {
                    completion(.failure(.errorDecoding))
                }
            }
            
        }
        task.resume()
    }
    
    func downloadImage(from url: String, completion: @escaping (UIImage?) -> Void) {
        if let image = imageCache.image(for: url) {
            completion(image)
            return
        }
        
        URLSession.shared.dataTask(with: URL(string: url)!) { data, response, error in
            if let data = data, let image = UIImage(data: data) {
                self.imageCache.cache(image: image, for: url)
                completion(image)
            } else {
                completion(nil)
            }
        }.resume()
    }
}
