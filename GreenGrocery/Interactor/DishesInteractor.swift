//
//  HomeInteractor.swift
//  GreenGrocery
//
//  Created by ENMANUEL TORRES on 15/04/24.
//

import Foundation

typealias SkuItem = (skuId: String, quantity: Int)

class DishesInteractor {
    
    var service: GroceriesAPI
    var database: CartDB
   
    init(service: GroceriesAPI, database: CartDB) {
        self.service = service
        self.database = database
    }
}

extension DishesInteractor {
    
    func getCategories(completion: @escaping CategoriesClosure) -> Void {
        self.service.fetchCategories(completion: completion)
    }
    
    func getGroceries(categoryName: String, completion: @escaping GroceriesClosure) -> (Void) {
        self.service.fetchGroceries(categoryName: categoryName, completion: completion)
    }
}
