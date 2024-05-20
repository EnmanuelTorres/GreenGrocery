//
//  TabBarModuleBuilder.swift
//  GreenGrocery
//
//  Created by ENMANUEL TORRES on 18/05/24.
//

import UIKit

class TabBarModuleBuilder {
    
    static func build(usingSubmodules submodules: TabBarRouter.Submodules) -> UITabBarController {
        let tabs = TabBarRouter.tabs(usingSubmodules: submodules)
        let interactor = CartInteractor(database: Database.shared)
        let presenter = TabBarPresenter(interactor: interactor)
        let tabBarController = GroceryTabBarController(tabs: tabs, presenter: presenter)
        presenter.view = tabBarController
        return tabBarController
    }
}
