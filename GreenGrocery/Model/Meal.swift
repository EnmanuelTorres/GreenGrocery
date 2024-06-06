//
//  Meal.swift
//  GreenGrocery
//
//  Created by ENMANUEL TORRES on 5/06/24.
//

import Foundation

struct MealsResponse: Codable {
    let meals: [Meal]
    
    enum CodingKeys: String, CodingKey {
        case meals = "meals"
    }
    
    
}


struct Meal: Codable{
    let id: String
    let name: String
    let image: String
    
    enum CodingKeys: String, CodingKey {
        case id = "idMeal"
        case name = "strMeal"
        case image = "strMealThumb"
    }
}
