//
//  CategoriesViewModel.swift
//  NYTTestTask
//
//  Created by Eugene Ned on 06.07.2023.
//

import Foundation
import RealmSwift

class CategoriesViewModel: ObservableObject {
    
    private let apiService = NYTAPIService.shared
    
    @Published private(set) var categories: [Category] = []
    
    func fetchCategories(completion: @escaping (NYTError?) -> Void) {
        apiService.getCategories { result in
            switch result {
            case .success(let categories):
                DispatchQueue.main.async {
                    self.categories = categories
                }
                completion(nil)
            case .failure(let error):
                if self.categories.isEmpty {
                    DispatchQueue.main.async {
                        do {
                            let realm = try Realm()
                            let cachedCategories = Array(realm.objects(Category.self))
                            self.categories = cachedCategories
                            
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
