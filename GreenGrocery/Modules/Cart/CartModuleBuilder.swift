//
//  CartModuleBuilder.swift
//  GreenGrocery
//
//  Created by ENMANUEL TORRES on 18/05/24.
//

import UIKit

class CartModuleBuilder {
    
    static func build(usingNavigationFactory factory: NavigationFactory) -> UIViewController {
        let storyboard = UIStoryboard.init(name: "Cart", bundle: nil)
        let view = storyboard.instantiateViewController(withIdentifier: "CartViewController") as! CartViewController
        view.title = "Cart"
        return factory(view)
    }
}
