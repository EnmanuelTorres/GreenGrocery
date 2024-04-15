//
//  HomeModuleBuilder.swift
//  GreenGrocery
//
//  Created by ENMANUEL TORRES on 15/04/24.
//

import UIKit

class HomeModuleBuilder {
    
    static func build() -> UIViewController {
       
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let view = storyboard.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
        let interactor = HomeInteractor()
        let router = HomeRouter(viewController: view)
        let presenter = HomePresenter(view: view, interactor: interactor, router: router)
        view.presenter = presenter
        
        return view
    }
}
