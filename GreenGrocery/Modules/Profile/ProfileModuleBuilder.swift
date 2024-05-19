//
//  ProfileModuleBuilder.swift
//  GreenGrocery
//
//  Created by ENMANUEL TORRES on 18/05/24.
//

import UIKit

class ProfileModuleBuilder {
    
    static func build(usingNavigationFactory factory: NavigationFactory) -> UIViewController {
        let storyboard = UIStoryboard.init(name: "Profile", bundle: nil)
        let view = storyboard.instantiateViewController(withIdentifier: "ProfileViewController") as! ProfileViewController
        view.title = "Profile"
        return factory(view)
    }
}
