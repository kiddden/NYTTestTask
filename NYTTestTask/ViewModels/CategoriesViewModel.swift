//
//  CategoriesViewModel.swift
//  NYTTestTask
//
//  Created by Eugene Ned on 06.07.2023.
//

import Foundation

class CategoriesViewModel: ObservableObject {
    
    private let apiService = NYTAPIService.shared
    
    @Published private(set) var categories: [Category] = []
    
    private(set) var isLoading: Bool = false
    
    func fetchCategories(completion: @escaping (NYTError?) -> Void) {
        self.isLoading = true
        apiService.getCategories { result in
            switch result {
            case .success(let categories):
                self.categories = categories
                self.isLoading = false
                completion(nil)
            case .failure(let error):
                self.isLoading = false
                completion(error)
            }
        }
    }
}
