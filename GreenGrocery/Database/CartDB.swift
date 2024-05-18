//
//  CartDB.swift
//  GreenGrocery
//
//  Created by ENMANUEL TORRES on 17/05/24.
//

import Foundation

protocol CartDB {
   func updateCart(using cartItem: CartItem) -> (Bool)
}
