//
//  TabBarRouter.swift
//  GreenGrocery
//
//  Created by ENMANUEL TORRES on 18/05/24.
//

import UIKit

class TabBarRouter {
    
    var viewController: UIViewController
    
    typealias Submodules = (
        home: UIViewController,
        cart: UIViewController,
        profile: UIViewController
    )
    
    init(viewController: UIViewController) {
        self.viewController = viewController
    }
}

extension TabBarRouter {
    
    static func tabs(usingSubmodules submodules: Submodules) -> GroceryTabs {
        
        let homeTabBarItem = UITabBarItem(title: "Home", image: UIImage(named: "tab-home"), tag: 11)
        let cartTabBarItem = UITabBarItem(title: "Cart", image: UIImage(named: "tab-cart"), tag: 12)
        let profileTabBarItem = UITabBarItem(title: "Profile", image: UIImage(named: "tab-profile"), tag: 13)
        
        submodules.home.tabBarItem = homeTabBarItem
        submodules.cart.tabBarItem = cartTabBarItem
        submodules.profile.tabBarItem = profileTabBarItem
        
        return (
            home: submodules.home,
            cart: submodules.cart,
            profile: submodules.profile
        )
    }
}
