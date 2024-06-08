//
//  ImageHttpRouter.swift
//  GreenGrocery
//
//  Created by ENMANUEL TORRES on 2/06/24.
//

import Alamofire
import Foundation


enum ImageHttpRouter {
    case downloadImage(imageName: String)
    case downloadThumbnail(imageName: String)
}

extension ImageHttpRouter {
    var baseUrlString: String {
        return "https://letscodeeasy.com/groceryapi/public/api"
    }
    
    var path: String {
        switch (self) {
            
        case .downloadImage(imageName: let imageName):
            return  "https://www.themealdb.com/images/category/\(imageName).png"
            
        case .downloadThumbnail(imageName: let imageName):
            return "\(imageName)"
        }
    }
    
    var method: Alamofire.HTTPMethod {
        return .get
    }
    
    var headers: Alamofire.HTTPHeaders? {
        return nil
    }
    
    var parameters: Alamofire.Parameters? {
        return nil
    }
    
    var urlString: String {
        return path
    }
    
    func asURLRequest() throws -> URLRequest {
        var url = try  urlString.asURL()
       
        var request = try URLRequest(url: url, method: method, headers: headers)
        return request
    }
    
    func request(usingHttpService service: ImageHttpService, completion: @escaping ImageDataResponse) throws -> Void {
        try service.download(asURLRequest(), completion: completion)
    }
    
}
