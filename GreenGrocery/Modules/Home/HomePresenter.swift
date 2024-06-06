//
//  HomePresenter.swift
//  GreenGrocery
//
//  Created by ENMANUEL TORRES on 15/04/24.
//

import Foundation

protocol HomePresentation {
    func viewDidLoad() -> Void
    func onFetchThumbnail(imageName: String, completion: @escaping ImageClosure) -> Void
    func onCategorySelection(usingCategory category: (id: Int, title: String, description: String)) -> (Void)
}

class HomePresenter {
    weak var view: HomeView?
    var router: HomeRouting?
    typealias UseCase = (
        getCategories: (_ completion: @escaping CategoriesClosure) -> Void,
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
    func onFetchThumbnail(imageName: String, completion: @escaping ImageClosure) {
        DispatchQueue.global(qos: .background).async { [weak self] in
            self?.useCase?.fetchThumbnail(imageName) { image in
                completion(image)
            }
        }
    }
    
    func onCategorySelection(usingCategory category: (id: Int, title: String, description: String)) {
        self.router?.routeToDishesListing(usingCategory: category)
    }
    
   
    func viewDidLoad() {
        DispatchQueue.global(qos: .background).async { [weak self] in
            self?.useCase?.getCategories ({ categories in

                self?.view?.loadCategories(categoriesList: categories.compactMap{ CategoryItemViewModel(using: $0)})
            })
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
