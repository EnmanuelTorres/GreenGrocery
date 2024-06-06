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
        view.title = "Dishes Category".uppercased()
        let router = HomeRouter(view: view)
        let homeInteractor = DishesInteractor(service: GroceryService.shared, database: Database.shared)
        let cartInteractor = CartInteractor(database: Database.shared)
        let imageInteractor = ImageInteractor(service: GroceryService.shared)
        
        view.presenter = HomePresenter(view: view, router: router, useCase: (
            getCategories: homeInteractor.getCategories,
            getCartItem: cartInteractor.getCartItem,
            fetchThumbnail: imageInteractor.fetchThumbnail
        ))
        return factory(view)
    }
}

