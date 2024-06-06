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
    
  //  www.themealdb.com/api/json/v1/1/filter.php?c=
    
    var path: String {
        switch (self) {
        case .getGroceryCategories:
            return "/categories.php"
        case .getGroceries(let categoryId):
            return "/filter.php?c=\(categoryId)"
          //  return "/category/\(categoryId)"
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
//        switch self {
//        case .downloadThumbnail:
//            return path
//        default:
//            return baseUrlString + path
//        }
        
        return baseUrlString + path
    }
    
    func body() throws -> Data? {
        switch self {
        case .getGroceryCategories, .getGroceries:
            return nil
        }
    }
}
