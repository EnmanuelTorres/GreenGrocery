//
//  DishesListModuleBuilder.swift
//  GreenGrocery
//
//  Created by ENMANUEL TORRES on 2/06/24.
//

import UIKit

class DishesListModuleBuilder {
    
    static func build(usingCategory category: (id: Int, title: String, description: String)) -> UIViewController {
        let storyboard = UIStoryboard.init(name: "Dishes", bundle: nil)
        let view = storyboard.instantiateViewController(withIdentifier: "DishesListViewController") as! DishesListViewController
        view.title = category.title.uppercased()
        
        let imageInteractor = ImageInteractor(service: GroceryService.shared)
        let groceriesInteractor = DishesInteractor(service: GroceryService.shared, database: Database.shared)
        let useCase = (
            fetchGroceries: groceriesInteractor.getGroceries,
            fetchImage: imageInteractor.fetchImage,
            fetchThumbnail: imageInteractor.fetchThumbnail
        )
        let router = DishesListRouter(viewController: view)
        let presenter = DishesListPresenter(categoryName: category.title, categoryDescription: category.description, router: router, useCase: useCase)
        presenter.view = view
        view.presenter = presenter
        return view
    }
}
