//
//  GroceryTabBarController.swift
//  GreenGrocery
//
//  Created by ENMANUEL TORRES on 18/05/24.
//

import UIKit

typealias GroceryTabs = (
    home: UIViewController,
    cart: UIViewController,
    profile: UIViewController
)

protocol TabBarView: NSObject {
    func updateCartCount(count: Int) -> Void
}

class GroceryTabBarController: UITabBarController {
    
    var cartTab: UIViewController
    var presenter: TabBarPresentation?

    init(tabs: GroceryTabs, presenter: TabBarPresentation ) {
        self.presenter = presenter
        self.cartTab = tabs.cart
        super.init(nibName: nil, bundle: nil)
        viewControllers = [tabs.home, tabs.cart, tabs.profile]
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter?.viewDidLoad()
    }
}

extension GroceryTabBarController: TabBarView {
    func updateCartCount(count: Int) {
        self.cartTab.tabBarItem.badgeValue =  count > 0  ?"\(count)" : nil
    }
    
    
}
