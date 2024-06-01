//
//  HomeModuleBuilder.swift
//  GreenGrocery
//
//  Created by ENMANUEL TORRES on 15/04/24.
//

import UIKit

class HomeModuleBuilder {
    
    static func build(usingNavigationFactory factory: NavigationFactory) -> UINavigationController {
       
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let view = storyboard.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
        view.title = "Fresh Groceries"
      //  let homeInteractor = HomeInteractor(service: StubService.shared, database: Database.shared)
      //  GroceryService.shared
        let homeInteractor = HomeInteractor(service: GroceryService.shared, database: Database.shared)
        let cartInteractor = CartInteractor(database: Database.shared)
        let router = HomeRouter(viewController: view)
        let imageInteractor = ImageInteractor(service: GroceryService.shared)
        let presenter = HomePresenter(view: view, router: router, useCase: (
            getCategories: homeInteractor.getCategories,
            addToCart: cartInteractor.addToCart,
            getCartItem: cartInteractor.getCartItem,
            fetchThumbnail: imageInteractor.fetchThumbnail
        ))
        view.presenter = presenter
        
        return factory(view)
    }
}
