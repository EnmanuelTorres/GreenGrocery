//
//  GroceriesAPI.swift
//  GreenGrocery
//
//  Created by ENMANUEL TORRES on 22/05/24.
//

typealias GroceriesClosure = (GroceryResult) -> (Void)
typealias CategoriesClosure = (CategoriesResponse) -> (Void)

protocol GroceriesAPI {
    func fetchCategories(completion: @escaping CategoriesClosure) -> Void
    func fetchGroceries(completion: GroceriesClosure) -> (Void)
}
