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
    case getGroceries(categoryId: String)
    case downloadThumbnail(imageName: String)
    case downloadImage(imageName: String)
}

extension GroceryHttpRouter: HttpRouter {
    
    var baseUrlString: String {
      //  return "https://letscodeeasy.com/groceryapi/public/api"
        
//        switch self {
//        case .getGroceryCategories:
//            return "https://www.themealdb.com/api/json/v1/1"
//        case .downloadThumbnail(imageName: <#T##String#>):
//            return imageName
//        default:
//            return "https://www.themealdb.com/images"
//        }
       
        return "https://www.themealdb.com/api/json/v1/1"
        
        
    }
    
    var path: String {
        switch (self) {
        case .getGroceryCategories:
            return "/categories.php"
        case .getGroceries(let categoryId):
            return "/category/\(categoryId)"
        case .downloadThumbnail(let imageName):
            print("\(imageName.lowercased())")
         //   return  "https://www.themealdb.com/images/category/\(imageName.lowercased())"
        //    return "/thumbnail/show/\(imageName)"
            return "\(imageName)"
        case .downloadImage(let imageName):
            return "/image/show/\(imageName)"
        }
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    var headers: HTTPHeaders? {
//        return [
//            "Content-Type": "application/json; charset=UTF-8"
//        ]
        return nil
    }
    
    var parameters: Parameters? {
        return nil
    }
    
    var urlString: String {
        switch self {
        case .downloadThumbnail:
            return path
        default:
            return baseUrlString + path
        }
    }
    
    func body() throws -> Data? {
        switch self {
        case .getGroceryCategories, .getGroceries, .downloadThumbnail, .downloadImage:
            return nil
        }
    }
}
