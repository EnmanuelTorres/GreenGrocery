//
//  HomeRouter.swift
//  GreenGrocery
//
//  Created by ENMANUEL TORRES on 15/04/24.
//

import UIKit

protocol HomeRouting {
    func routeToDishesListing(usingCategory category: (id: Int, title: String, description: String)) -> Void
}

class HomeRouter {
    var view: UIViewController
    
    init(view: UIViewController) {
        self.view = view
    }
}

extension HomeRouter: HomeRouting {
    func routeToDishesListing(usingCategory category: (id: Int, title: String, description: String)) {
        let dishesList = DishesListModuleBuilder.build(usingCategory: category)
        self.view.navigationController?.pushViewController(dishesList, animated: true)
    }
}
