//
//  HomePresenter.swift
//  GreenGrocery
//
//  Created by ENMANUEL TORRES on 15/04/24.
//

import Foundation

protocol HomePresentation {
    func viewDidLoad() -> Void
}

class HomePresenter {
    weak var view: HomeView?
    var interactor: HomeUseCase
    var router: HomeRouting
    
    init(view: HomeView, interactor: HomeUseCase, router: HomeRouting) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
    
    
}

extension HomePresenter: HomePresentation {
    func viewDidLoad() {
        let homeModel = self.interactor.getTitle()
        print("debud: \(homeModel)")
        
        DispatchQueue.main.async { [weak self] in
            guard let self = self else {return }
            self.view?.updateTitle(title: homeModel.title)

        }
    }
    
    
}
