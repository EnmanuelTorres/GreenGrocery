//
//  NavigationBuilder.swift
//  GreenGrocery
//
//  Created by ENMANUEL TORRES on 17/05/24.
//

import UIKit

typealias NavigationFactory = (UIViewController) -> (UINavigationController)

class NavigationBuilder {
    
    static func build(rootView: UIViewController) -> UINavigationController {
        
        let textStyleAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor : UIColor.white,
            .font : UIFont.init(name: "AvenirNext-DemiBold", size: 22.0)!
        ]
        
        let largeTextStyleAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor : UIColor.white,
            .font : UIFont.init(name: "AvenirNext-DemiBold", size: 28.0)!
        ]
        
        let navigationController = UINavigationController(rootViewController: rootView)
        navigationController.navigationBar.barTintColor = ThemeColor.primary
        navigationController.navigationBar.backgroundColor =  ThemeColor.primary
        navigationController.navigationBar.tintColor = UIColor.white
        navigationController.navigationBar.titleTextAttributes = textStyleAttributes
        navigationController.navigationBar.largeTitleTextAttributes = largeTextStyleAttributes
        navigationController.navigationBar.isTranslucent = false
        navigationController.navigationBar.prefersLargeTitles = true
        return navigationController
    }
}
