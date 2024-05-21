//
//  CartInteractor.swift
//  GreenGrocery
//
//  Created by ENMANUEL TORRES on 19/05/24.
//

import Foundation


class CartInteractor {
    
    var database: CartDB
    
    init(database: CartDB) {
        self.database = database
    }
}

extension CartInteractor {
    
    func getCartCount(closure: @escaping CartCountClosure) {
        self.database.getCount(closure: closure)
    }
    
    func getCartItem(skuId: String) -> CartItem {
        return self.database.getCartItem(usingSkuId: skuId)
    }
    
    func addToCart(skuItem: SkuItem) -> Bool {
        
        guard skuItem.quantity > 0 else {
            return self.database.delete(usingSkuId: skuItem.skuId)
        }
        return self.database.updateCart(using: CartItem(skuId: skuItem.skuId, value: skuItem.quantity))
    }
}
