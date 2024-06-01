//
//  Category.swift
//  GreenGrocery
//
//  Created by ENMANUEL TORRES on 22/05/24.
//

import Foundation

//struct Category: Codable {
//    let id: Int
//    let category: String
//    let description: String
//    let imageId: String
//    let createdAt: String?
//    let updatedAt: String?
//    let categoryImage: CategoryImage
//    
//    private enum CodingKeys: String, CodingKey {
//        case id
//        case category
//        case description
//        case imageId = "image_id"
//        case categoryImage = "image"
//        case createdAt = "created_at"
//        case updatedAt = "updated_at"
//    }
//}
//
//struct CategoryImage: Codable {
//    let id: Int
//    let name: String
//    let createdAt: String?
//    let updatedAt: String?
//    
//    private enum CodingKeys: String, CodingKey {
//        case id
//        case name
//        case createdAt = "created_at"
//        case updatedAt = "updated_at"
//    }
//}

struct CategoriesResponse: Codable {
    let categories: [Category]
}

struct Category: Codable {
    let id: String
    let name: String
    let image: String
    let description: String
    
    enum CodingKeys: String, CodingKey {
        case id = "idCategory"
        case name = "strCategory"
        case image = "strCategoryThumb"
        case description = "strCategoryDescription"
    }
}
