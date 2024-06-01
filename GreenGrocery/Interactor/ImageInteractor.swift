//
//  ImageInteractor.swift
//  GreenGrocery
//
//  Created by ENMANUEL TORRES on 31/05/24.
//

import Foundation

final class ImageInteractor {
    let service: ImagesAPI
    init(service: ImagesAPI) {
        self.service = service
    }
}

extension ImageInteractor {
    func fetchThumbnail(imageName: String, completion: @escaping ImageClosure) -> Void {
        self.service.fetchThumbnail(imageName: imageName, completion: completion)
    }
    
    func fetchImage(imageName: String, completion: @escaping ImageClosure) -> Void {
        self.service.fetchImage(imageName: imageName, completion: completion)
    }
}
