//
//  service.swift
//  GreenGrocery
//
//  Created by ENMANUEL TORRES on 11/05/24.
//

import Foundation

typealias GroceriesClosure = (GroceryResult) -> (Void)
protocol GroceriesAPI {
    func fetchGroceries(completion: GroceriesClosure) -> ( Void)
}


class Service {
    
    static let shared: Service = Service()
    private init(){}
}

extension Service: GroceriesAPI {
    
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
