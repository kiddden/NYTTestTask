//
//  BooksViewModel.swift
//  NYTTestTask
//
//  Created by Eugene Ned on 06.07.2023.
//

import Foundation
import RealmSwift

class BooksViewModel: ObservableObject {
    
    private let apiService = NYTAPIService.shared
    
    @Published private(set) var books: [Book] = []
    
    func fetchBooks(for category: Category, completion: @escaping (NYTError?) -> Void) {
        
        
        apiService.getBooks(for: category) { result in
            switch result {
            case .success(let books):
                DispatchQueue.main.async {
                    self.books = books
                }
                completion(nil)
            case .failure(let error):
                if self.books.isEmpty {
                    DispatchQueue.main.async {
                        do {
                            let realm = try Realm()
                            
                            let objectId = try ObjectId(string: category._id.stringValue)
                            let cachedBooks = Array(realm.objects(Book.self).filter("categoryID == %@", objectId.stringValue))
                            self.books = cachedBooks
                            
                            completion(nil)
                        } catch {
                            completion(.errorRetreivingCache)
                        }
                    }
                } else {
                    completion(error)
                }
            }
        }
    }
}
