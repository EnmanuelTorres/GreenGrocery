//
//  GroceriesAPI.swift
//  GreenGrocery
//
//  Created by ENMANUEL TORRES on 22/05/24.
//

typealias GroceriesClosure = (MealsResponse) -> (Void)
typealias CategoriesClosure = ([Category]) -> (Void)

protocol GroceriesAPI {
    func fetchCategories(completion: @escaping CategoriesClosure) -> Void
    func fetchGroceries(categoryName: String, completion: @escaping GroceriesClosure) -> (Void)
}
