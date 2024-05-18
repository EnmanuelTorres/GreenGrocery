//
//  HomeInteractor.swift
//  GreenGrocery
//
//  Created by ENMANUEL TORRES on 15/04/24.
//

import Foundation

typealias SkuItem = (skuId: String, quantity: Int)

protocol HomeUseCase {
   
    func getGroceries(completion: GroceriesClosure) -> (Void)
    func addToCart(skuItem: SkuItem) -> Bool
}

class HomeInteractor {
    
    var service: GroceriesAPI
    var database: CartDB
   
    init(service: GroceriesAPI, database: CartDB) {
        self.service = service
        self.database = database
    }
}

extension HomeInteractor: HomeUseCase {
  
    
    
    func getGroceries(completion: (GroceryResult) -> (Void)) {
        self.service.fetchGroceries { result in
            completion(result)
        }
        
    }
    
    
    func addToCart(skuItem: SkuItem) -> Bool {
        return database.updateCart(using: CartItem(skuId: skuItem.skuId, value: skuItem.quantity))
    }
}
