//
//  GroceryService.swift
//  GreenGrocery
//
//  Created by ENMANUEL TORRES on 22/05/24.
//

import Alamofire
import Foundation

class GroceryService {
    private lazy var httpService = GroceryHttpService()
    static let shared : GroceryService = GroceryService()
}

extension GroceryService: GroceriesAPI {
    
//    func fetchCategories(completion: @escaping (CategoriesResponse) -> (Void)) {
//        // Start making the http call to fetch categories
//        do {
//            try GroceryHttpRouter
//                .getGroceryCategories
//                .request(usingHttpService: httpService)
//                .responseDecodable(of: CategoriesResponse.self) { response in
//                    switch response.result {
//                    case .success(let categories):
//                        completion(categories)
//                    case .failure(let error):
//                        print("Somethinggg went wrong while fetching categories! \(error)")
//                     //   completion(nil)
//                    }
//                }
//            
//        } catch {
//            print("Something went wrong while fetching categories! = \(error)")
//        }
//    }
    
    func fetchCategories(completion: @escaping (CategoriesResponse) -> (Void)) {
        // Start making the http call to fetch categories
        do {
            try GroceryHttpRouter
                .getGroceryCategories
                .request(usingHttpService: httpService)
                .responseJSON { (result) in
                    let categories = GroceryService.parseCategories(result: result)
                    completion(categories)
                }
        } catch {
            print("Something went wrong while fetching categories! = \(error)")
        }
    }
    func fetchGroceries(completion: (GroceryResult) -> (Void)) {
        
    }
}


extension GroceryService: ImagesAPI {
    
    func fetchImage(imageName: String, completion: @escaping ImageClosure) {
        do {
            try GroceryHttpRouter
                .downloadImage(imageName: imageName)
                .request(usingHttpService: httpService)
                .responseData(completionHandler: { (result) in
                    completion(result.data)
                })

        } catch {
            print("Something went wrong while fetching image! = \(error)")
        }
    }
    
    func fetchThumbnail(imageName: String, completion: @escaping ImageClosure) {
        do {
            try GroceryHttpRouter
                .downloadThumbnail(imageName: imageName)
                .request(usingHttpService: httpService)
                .responseData(completionHandler: { (result) in
                    completion(result.data)
                })
        } catch {
            print("Something went wrong while fetching thumbnail! = \(error)")
        }
    }
}

extension GroceryService {
    
    private static func parseCategories(result: DataResponse<Any, AFError>) -> CategoriesResponse {
        
        guard [200, 201].contains(result.response?.statusCode), let data = result.data else { return CategoriesResponse(categories: [])  }
        
        do {
//            let categories = try JSONDecoder().decode(Array<Category>.self, from: data)
//            return  CategoriesResponse(categories: categories)
            return try JSONDecoder().decode(CategoriesResponse.self, from: data)
        } catch {
            print("Something went wrong while parsing categories response")
        }
        return CategoriesResponse(categories: [])
    }
}


