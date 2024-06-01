//
//  HttpRouter.swift
//  GreenGrocery
//
//  Created by ENMANUEL TORRES on 22/05/24.
//

import Alamofire
import Foundation

protocol HttpRouter: URLRequestConvertible {
    var baseUrlString: String { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var headers: HTTPHeaders? { get }
    var parameters: Parameters? { get }
    var urlString: String { get }
    func body() throws -> Data?
    
    func request(usingHttpService service: HttpService) throws -> DataRequest
}

extension HttpRouter {
    
    var parameter: Parameters? { return nil }
    func body() throws -> Data? { return nil }
    
    func asURLRequest() throws -> URLRequest {
//        var url = try baseUrlString.asURL()
//        url.appendPathComponent(path)
        var url = try  urlString.asURL()
        print("Debug: this is the url: \(url)")
        
        var request = try URLRequest(url: url, method: method, headers: headers)
        request.httpBody = try body()
        return request
    }
    
    
    
    func request(usingHttpService service: HttpService) throws -> DataRequest {
        return try service.request(asURLRequest())
    }
}
