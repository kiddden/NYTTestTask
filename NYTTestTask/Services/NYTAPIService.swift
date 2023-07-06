//
//  NYTAPIService.swift
//  NYTTestTask
//
//  Created by Eugene Ned on 06.07.2023.
//

import Foundation

class NYTAPIService {
    
    static let shared = NYTAPIService()
    
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
            do {
                let decoder = JSONDecoder()
                let response = try decoder.decode(TopLevelNYTResponse<[Category]>.self, from: data)
                completion(.success(response.results))
            } catch {
                completion(.failure(.errorDecoding))
            }
            
        }
        task.resume()
    }
    
    func getBooks(for category: Category, completion: @escaping(Result<[Book], NYTError>) -> Void) {
        let endpoint = baseURL + "lists/\(category.publishedDate)/\(category.nameEncoded).json?api-key=\(APIKey)"
        print(endpoint)
        
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
            do {
                let decoder = JSONDecoder()
                let response = try decoder.decode(TopLevelNYTResponse<BottomLevelNYTResponse>.self, from: data)
                completion(.success(response.results.books))
            } catch {
                completion(.failure(.errorDecoding))
            }
            
        }
        task.resume()
    }
}
