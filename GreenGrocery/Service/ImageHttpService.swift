//
//  ImageHttpService.swift
//  GreenGrocery
//
//  Created by ENMANUEL TORRES on 2/06/24.
//

import Alamofire
import AlamofireImage

typealias ImageDataResponse = (AFIDataResponse<Image>) -> Void

final class ImageHttpService {
    let downloader: ImageDownloader
    static let shared : ImageHttpService = ImageHttpService()

    private init() {
        downloader = ImageDownloader()
    }
    
    func download(_ urlRequest: URLRequestConvertible, completion: @escaping ImageDataResponse) -> Void {
        downloader.download(urlRequest, completion: completion)
    }
}
