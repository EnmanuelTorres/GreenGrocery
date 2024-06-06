//
//  ImagesAPI.swift
//  GreenGrocery
//
//  Created by ENMANUEL TORRES on 22/05/24.
//

import UIKit

typealias ImageClosure = (UIImage) -> Void
protocol ImagesAPI {
    func fetchThumbnail(imageName: String, completion: @escaping ImageClosure) -> Void
    func fetchImage(imageName: String, completion: @escaping ImageClosure) -> Void
}
