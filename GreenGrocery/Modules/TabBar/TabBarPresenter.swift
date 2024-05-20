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
    var interactor: CartUseCase
    
//    typealias UseCase = (
//        getCartCount: (@escaping CartCountClosure) -> Void, ()
//    )
  //  var useCase: UseCase
    
    init( interactor: CartInteractor) {
        self.interactor = interactor
    }
}

extension TabBarPresenter: TabBarPresentation {
    
    func viewDidLoad() {
        self.interactor.getCartCount {
            self.view?.updateCartCount(count: $0)
        }
    }
}
