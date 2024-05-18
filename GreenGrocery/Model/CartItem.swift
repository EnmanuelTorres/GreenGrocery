//
//  CartItem.swift
//  GreenGrocery
//
//  Created by ENMANUEL TORRES on 17/05/24.
//

import Foundation

struct CartItem {
    let skuId: String
    let value: Int
    
    init(skuId: String, value: Int) {
        self.skuId = skuId
        self.value = value
    }
}
