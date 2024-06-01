//
//  StubService.swift
//  GreenGrocery
//
//  Created by ENMANUEL TORRES on 11/05/24.
//

import Foundation

class StubService {
    
    static let shared: StubService = StubService()
    private init(){}
}

extension StubService: GroceriesAPI {
    func fetchCategories(completion: @escaping CategoriesClosure) {
        fatalError("No implementation for this yet!")
    }
    
    
    func fetchGroceries(completion: (GroceryResult) -> (Void)) {
        
        if let url = Bundle.main.url(forResource: "products", withExtension: "json") {
            
            do {
                let data = try Data(contentsOf: url)
                let groceryResult = try JSONDecoder().decode(GroceryResult.self, from: data)
                completion(groceryResult)
            } catch {
                print("Something went wrong with error = \(error)")
            }
        }
    }
}
