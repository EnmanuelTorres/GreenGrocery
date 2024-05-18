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
        let interactor = HomeInteractor(service: Service.shared, database: Database.shared)
        let router = HomeRouter(viewController: view)
        let presenter = HomePresenter(view: view, interactor: interactor, router: router)
        view.presenter = presenter
        
        return factory(view)
    }
}
