//
//  HomeInteractor.swift
//  GreenGrocery
//
//  Created by ENMANUEL TORRES on 15/04/24.
//

import Foundation

protocol HomeUseCase {
   
    func getGroceries(completion: GroceriesClosure) -> (Void)
}

class HomeInteractor {
    
    var service: GroceriesAPI
   
    init(service: GroceriesAPI) {
        self.service = service
    }
}

extension HomeInteractor: HomeUseCase {
    
    func getGroceries(completion: (GroceryResult) -> (Void)) {
        self.service.fetchGroceries { result in
            completion(result)
        }
        
    }
    
}
