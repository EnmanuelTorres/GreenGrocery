//
//  GroceryHttpRouter.swift
//  GreenGrocery
//
//  Created by ENMANUEL TORRES on 22/05/24.
//

import Foundation
import Alamofire


enum GroceryHttpRouter {
    case getGroceryCategories
    case getGroceries(categoryName: String)
   
}

extension GroceryHttpRouter: HttpRouter {
    
    var baseUrlString: String {
       
        return "https://www.themealdb.com/api/json/v1/1"
    }
    
    var path: String {
        switch (self) {
        case .getGroceryCategories:
            return "/categories.php"
        case .getGroceries(let categoryId):
            return "/filter.php?c=\(categoryId)"
        }
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    var headers: HTTPHeaders? {
        return nil
    }
    
    var parameters: Parameters? {
        return nil
    }
    
    var urlString: String {
        return baseUrlString + path
    }
    
    func body() throws -> Data? {
        switch self {
        case .getGroceryCategories, .getGroceries:
            return nil
        }
    }
}
