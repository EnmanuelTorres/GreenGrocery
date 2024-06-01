//
//  GroceryHttpService.swift
//  GreenGrocery
//
//  Created by ENMANUEL TORRES on 22/05/24.
//

import Alamofire

final class GroceryHttpService: HttpService {
    var sessionManger: Session = Session.default
    
    func request(_ urlRequest: URLRequestConvertible) -> DataRequest {
        return sessionManger.request(urlRequest).validate(statusCode: 200..<400)
    }
}
