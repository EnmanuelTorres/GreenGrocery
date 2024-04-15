//
//  HomeRouter.swift
//  GreenGrocery
//
//  Created by ENMANUEL TORRES on 15/04/24.
//

import UIKit

protocol HomeRouting {
    
}

class HomeRouter {
    var viewController: UIViewController
    
    init(viewController: UIViewController) {
        self.viewController = viewController
    }
}

extension HomeRouter: HomeRouting {
    
}
