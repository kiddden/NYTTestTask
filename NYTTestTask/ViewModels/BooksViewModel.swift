//
//  BooksViewModel.swift
//  NYTTestTask
//
//  Created by Eugene Ned on 06.07.2023.
//

import Foundation

class BooksViewModel: ObservableObject {
    
    private let apiService = NYTAPIService.shared
    
    @Published private(set) var books: [Book] = []
    
    private(set) var isLoading: Bool = false
    
    func fetchBooks(for category: Category, completion: @escaping (NYTError?) -> Void) {
        isLoading = true
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
