//
//  TabBarPresenter.swift
//  GreenGrocery
//
//  Created by ENMANUEL TORRES on 19/05/24.
//

import Foundation

protocol TabBarPresentation {
    
    func viewDidLoad() -> Void
}

class TabBarPresenter {
    
    weak var view: TabBarView?
   
    
    typealias UseCase = (
        getCartCount: (@escaping CartCountClosure) -> Void, ()
    )
    var useCase: UseCase
    
    init(useCase: TabBarPresenter.UseCase) {
        self.useCase = useCase
    }
}

extension TabBarPresenter: TabBarPresentation {
    
    func viewDidLoad() {
        self.useCase.getCartCount {
            self.view?.updateCartCount(count: $0)
        }
    }
}
