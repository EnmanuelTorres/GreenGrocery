//
//  DishesListRouter.swift
//  GreenGrocery
//
//  Created by ENMANUEL TORRES on 2/06/24.
//

import UIKit

protocol DishesListRouting {
    
}

class DishesListRouter {
    var viewController: UIViewController
    
    init(viewController: UIViewController) {
        self.viewController = viewController
    }
}

extension DishesListRouter: DishesListRouting {
    
}
