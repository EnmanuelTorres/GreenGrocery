//
//  GroceryResult.swift
//  GreenGrocery
//
//  Created by ENMANUEL TORRES on 11/05/24.
//

import Foundation

struct GroceryResult: Codable {
    let groceries: [Grocery]
}

struct Grocery: Codable {
    let skuId: String
    let title: String
    let image: String
    let details: String
    let price: Double
    
    private enum CodingKeys: String, CodingKey {
        case skuId = "sku-id"
        case title
        case image = "product_image"
        case details
        case price
    }
}
