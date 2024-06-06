//
//  DishesListPresenter.swift
//  GreenGrocery
//
//  Created by ENMANUEL TORRES on 2/06/24.
//

import Foundation

protocol GroceriesListPresentation {
    func viewDidLoad() -> Void
    func onThumnailUpdate(imageName: String, completion: @escaping ImageClosure) -> Void
}

class DishesListPresenter {
    
    var categoryName: String
    var categoryDescription: String
    var router: DishesListRouting
    var useCase: UseCase
    weak var view: DishesListView?
    
    typealias UseCase = (
        fetchGroceries: ( _ categoryName: String, _ completion: @escaping GroceriesClosure) -> Void,
        fetchImage: (_ imageName: String, _ completion: @escaping ImageClosure) -> Void,
        fetchThumbnail: (_ imageName: String, _ completion: @escaping ImageClosure) -> Void
    )
    
    init(categoryName: String, categoryDescription: String, router: DishesListRouting, useCase: UseCase) {
        self.categoryName = categoryName
        self.categoryDescription = categoryDescription
        self.router = router
        self.useCase = useCase
        
    }
}

extension DishesListPresenter: GroceriesListPresentation {
    func viewDidLoad() {
        self.view?.updateCoverTitle(title: self.categoryDescription)
        DispatchQueue.global(qos: .background).async {
            
            self.useCase.fetchImage(self.categoryName) { image in
                DispatchQueue.main.async {
                    self.view?.updateCoverImage(image: image)
                }
            }
         
            
            self.useCase.fetchGroceries(self.categoryName) { mealResponse in
                
                DispatchQueue.main.async {
                    let mealList = mealResponse.meals.compactMap{ DishItemViewModel(using: $0)}
                    self.view?.updateGroceries(groceriesList: mealList ?? [])
                }
                
            }
        }
    }
    
    func onThumnailUpdate(imageName: String, completion: @escaping ImageClosure) {
        DispatchQueue.global(qos: .background).async {
            self.useCase.fetchThumbnail(imageName) { data in
                completion(data)
            }
        }
    }
    
}


struct DishItemViewModel {
    
    let id: String
    let title: String
    let image: String
    
    init(using mealModel: Meal) {
        self.id = mealModel.id
        self.title = mealModel.name
        self.image = mealModel.image
    }
}
