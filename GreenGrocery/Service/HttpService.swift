//
//  HttpService.swift
//  GreenGrocery
//
//  Created by ENMANUEL TORRES on 22/05/24.
//

import Alamofire

protocol HttpService {
    var sessionManger: Session { get set }
    func request(_ urlRequest: URLRequestConvertible) -> DataRequest
}
