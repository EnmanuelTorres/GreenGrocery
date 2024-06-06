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
    private lazy var imageHttpService = ImageHttpService.shared
    static let shared : GroceryService = GroceryService()
}

extension GroceryService: GroceriesAPI {
   
    
    
    
    func fetchGroceries(categoryName: String, completion: @escaping (MealsResponse) -> (Void)) {
        do {
            try GroceryHttpRouter
                .getGroceries(categoryName: categoryName)
                .request(usingHttpService: httpService)
                .responseJSON { (result) in
                    let groceriesResult = GroceryService.parseGroceriesResult(result: result)
                    guard let meal = groceriesResult else { return }
                    completion(meal)
            }
        } catch {
            print("Something went wrong while fetching categories! = \(error)")
        }
    }
    
//    func fetchGroceries(completion: (Category) -> (Void)) {
//        do {
//            try GroceryHttpRouter
//                .getGroceries(categoryName: categoryId)
//                .request(usingHttpService: httpService)
//                .responseJSON { (result) in
//                    let groceriesResult = GroceryService.parseGroceriesResult(result: result)
//                    guard let category = groceriesResult else { return }
//                    completion(category)
//            }
//        } catch {
//            print("Something went wrong while fetching categories! = \(error)")
//        }
//    }
    
    
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
    
    func fetchCategories(completion: @escaping ([Category]) -> (Void)) {
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
   
}


extension GroceryService: ImagesAPI {
    
    func fetchImage(imageName: String, completion: @escaping ImageClosure) {
        do {
            try ImageHttpRouter
                .downloadImage(imageName: imageName)
                .request(usingHttpService: imageHttpService){ response in
                    switch response.result {
                    case .success(let image):
                        completion(image)
                    case .failure(let error):
                        print("estan llamando al fetchImage")
                        print("este es el name \(imageName)")
                        print("Something went wrong while fetching image! = \(error)")
                    }
                }
            
        } catch {
            print("Something went wrong while fetching image! = \(error)")
        }
    }
    
    
    func fetchThumbnail(imageName: String, completion: @escaping ImageClosure) {
        do {
            try ImageHttpRouter
                .downloadThumbnail(imageName: imageName)
                .request(usingHttpService: imageHttpService){ response in
                    switch response.result {
                    case .success(let image):
                        completion(image)
                    case .failure(let error):
                        print("Something went wrong while fetching Thumbnail! = \(error)")
                    }
                }
        } catch {
            print("Something went wrong while fetching thumbnail! = \(error)")
        }
    }
}

extension GroceryService {

    
    private static func parseCategories(result: DataResponse<Any, AFError>) -> [Category] {
        
        guard [200, 201].contains(result.response?.statusCode), let data = result.data else { return [] }
        
        do {
            let data = try JSONDecoder().decode(CategoriesResponse.self, from: data)
            return data.categories
        } catch {
            print("Something went wrong while parsing categories response: \(error)")
        }
        return []
    }
    
    
    private static func parseGroceriesResult(result: DataResponse<Any, AFError>) -> MealsResponse? {
        guard [200, 201].contains(result.response?.statusCode), let data = result.data else { return nil }
        
        do {
            return try JSONDecoder().decode(MealsResponse.self, from: data)
        } catch {
            print("Something went wrong while parsing groceries response: \(error)")
        }
        return nil
    }
}


