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
    var interactor: HomeUseCase?
    var router: HomeRouting?
    
    init(view: HomeView, interactor: HomeUseCase, router: HomeRouting) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
    
    
}

extension HomePresenter: HomePresentation {
    
    func viewDidLoad() {
        DispatchQueue.global(qos: .background).async { [weak self] in
            self?.interactor?.getGroceries { result in
               let groceryList = result.groceries.compactMap({GroceryItemViewModel(using: $0) })
                DispatchQueue.main.async {
                    self?.view?.updateGroceries(groceriesList: groceryList)
                }
            }
        }
        
       
    }
    
}

struct GroceryItemViewModel {
    
    let id: String
    let title: String
    let details: String
    let image: String
    let price: String
    
    init(using groceryModel: Grocery) {
        self.id = groceryModel.skuId
        self.title = groceryModel.title
        self.details = groceryModel.details
        self.image = groceryModel.image
        self.price = "$ \(groceryModel.price)"
    }
}
