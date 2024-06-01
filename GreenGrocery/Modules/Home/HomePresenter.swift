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
    func onFetchThumbnail(imageName: String, completion: @escaping (Data) -> Void) -> Void
}

class HomePresenter {
    weak var view: HomeView?
    var router: HomeRouting?
    typealias UseCase = (
        getCategories: (_ completion: @escaping CategoriesClosure) -> Void,
        addToCart: (SkuItem) -> Bool,
        getCartItem: (String) -> CartItem,
        fetchThumbnail: (_ imageName: String, _ completion: @escaping ImageClosure) -> Void
    )
    var useCase: UseCase?
    
    init(view: HomeView, router: HomeRouting, useCase: HomePresenter.UseCase ) {
        self.view = view
        self.router = router
        self.useCase = useCase
    }
    
}

extension HomePresenter: HomePresentation {
    func onFetchThumbnail(imageName: String, completion: @escaping (Data) -> Void) {
        DispatchQueue.global(qos: .background).async { [weak self] in
            self?.useCase?.fetchThumbnail(imageName) { data in
                guard let data = data else { return }
                completion(data)
            }
        }
    }
    
   
    func viewDidLoad() {
        DispatchQueue.global(qos: .background).async { [weak self] in
            self?.useCase?.getCategories ({ categories in
                print("Load categories: \(categories)")
                self?.view?.loadCategories(categoriesList: categories.categories.compactMap {  CategoryItemViewModel(using: $0)
                })
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

struct CategoryItemViewModel {
    
    let id: Int
    let title: String
    let details: String
    let imageName: String
    
    init(using categoryModel: Category) {
        self.id = Int(categoryModel.id) ?? 0
        self.title = categoryModel.name
        self.details = categoryModel.description
        self.imageName = categoryModel.image
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
