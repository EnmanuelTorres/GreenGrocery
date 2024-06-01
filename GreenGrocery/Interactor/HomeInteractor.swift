//
//  HomeInteractor.swift
//  GreenGrocery
//
//  Created by ENMANUEL TORRES on 15/04/24.
//

import Foundation

typealias SkuItem = (skuId: String, quantity: Int)

class HomeInteractor {
    
    var service: GroceriesAPI
    var database: CartDB
   
    init(service: GroceriesAPI, database: CartDB) {
        self.service = service
        self.database = database
    }
}

extension HomeInteractor {
    
    func getCategories(completion: @escaping CategoriesClosure) -> Void {
        self.service.fetchCategories(completion: completion)
    }
    
    func getGroceries(completion: (GroceryResult) -> (Void)) {
        self.service.fetchGroceries { result in
            completion(result)
        }
        
    }
}
