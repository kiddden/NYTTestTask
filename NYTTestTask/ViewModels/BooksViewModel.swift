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
    
    @Published private(set) var isLoading: Bool = false
    
    func fetchBooks(for category: Category, completion: @escaping (NYTError?) -> Void) {
        self.isLoading = true
        
        DispatchQueue.main.async {
            do {
                let realm = try Realm()
                
                let allBooks = Array(realm.objects(Book.self))
                for book in allBooks {
                    print("Book in database with categoryID: \(book.categoryID)")
                }
                let objectId = try ObjectId(string: category._id.stringValue)
                let cachedBooks = Array(realm.objects(Book.self).filter("categoryID == %@", objectId.stringValue))
                print("\(category._id.stringValue)\nCached Books: \(cachedBooks)")
                self.books = cachedBooks
                self.isLoading = false
                
                completion(nil)
            } catch {
                completion(.errorRetreivingCache)
            }
        }
        
        apiService.getBooks(for: category) { result in
            switch result {
            case .success(let books):
                self.books = books
                self.isLoading = false
                completion(nil)
            case .failure(let error):
                self.isLoading = false
                completion(error)
            }
        }
    }
}
