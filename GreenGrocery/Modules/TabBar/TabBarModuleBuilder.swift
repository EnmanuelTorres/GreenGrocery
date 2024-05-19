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
        let tabBarController = GroceryTabBarController(tabs: tabs)
        return tabBarController
    }
}
