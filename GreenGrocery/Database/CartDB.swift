//
//  CartDB.swift
//  GreenGrocery
//
//  Created by ENMANUEL TORRES on 17/05/24.
//

typealias CartCountClosure = (Int) -> (Void)

protocol CartDB {
    func getCartItem(usingSkuId skuId: String) -> CartItem
    func updateCart(using cartItem: CartItem) -> (Bool)
    func delete(usingSkuId skuId: String) -> (Bool)
    func getCount(closure: @escaping CartCountClosure) -> (Void)
 
}
