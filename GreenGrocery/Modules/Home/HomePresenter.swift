//
//  HomePresenter.swift
//  GreenGrocery
//
//  Created by ENMANUEL TORRES on 15/04/24.
//

import Foundation

protocol HomePresentation {
    func viewDidLoad() -> Void
    func onAddToCart(skuItem: SkuItem) -> Void
}

class HomePresenter {
    weak var view: HomeView?
    var router: HomeRouting?
    typealias UseCase = (
        getGroceries: (_ completion: (GroceryResult) -> (Void)) -> Void,
        addToCart: (SkuItem) -> Bool,
        getCartItem: (String) -> CartItem
    )
    var useCase: UseCase?
    
    init(view: HomeView, router: HomeRouting, useCase: HomePresenter.UseCase ) {
        self.view = view
        self.router = router
        self.useCase = useCase
    }
    
}

extension HomePresenter: HomePresentation {
   
    
    
    func viewDidLoad() {
        DispatchQueue.global(qos: .background).async { [weak self] in
            self?.useCase?.getGroceries({ (result) in
                let groceryList = result.groceries
                    .compactMap({ grocery -> GroceryItemViewModel in
                        let cartItem = self?.useCase?.getCartItem(grocery.skuId)
                        return GroceryItemViewModel(using: grocery, cartItem: cartItem!)
                })
                DispatchQueue.main.async {
                    self?.view?.updateGroceries(groceriesList: groceryList)
                }
            })
        }
    }
    
    func onAddToCart(skuItem: SkuItem) -> Void {
        
        DispatchQueue.global(qos: .background).async {
            let updated = self.useCase?.addToCart(skuItem)
            print("Add to cart updated with result: \(String(describing: updated))")
            
            DispatchQueue.main.async {
                /// Lets implement a spinner for this one
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
    let cartValue: CartValueViewModel
    
    init(using groceryModel: Grocery, cartItem: CartItem) {
        self.id = groceryModel.skuId
        self.title = groceryModel.title
        self.details = groceryModel.details
        self.image = groceryModel.image
        self.price = "$ \(groceryModel.price)"
        self.cartValue = CartValueViewModel(id: cartItem.skuId, stepValue: cartItem.value)
    }
       
}
