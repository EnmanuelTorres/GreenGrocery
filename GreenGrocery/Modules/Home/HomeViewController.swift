//
//  HomeViewController.swift
//  GreenGrocery
//
//  Created by ENMANUEL TORRES on 15/04/24.
//

import UIKit

protocol HomeView: AnyObject{
    func loadCategories(categoriesList: [CategoryItemViewModel]) -> ()
}

class HomeViewController: UIViewController {
    
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var topCategoryView: CategoryView!
    @IBOutlet weak var leftTopCategoryView: CategoryView!
    @IBOutlet weak var leftBottomCategoryView: CategoryView!
    @IBOutlet weak var rightCategoryView: CategoryView!
    
    lazy var categoryViews: [CategoryView] = [
        self.topCategoryView,
        self.leftTopCategoryView,
        self.leftBottomCategoryView,
        self.rightCategoryView
    ]
    
    var presenter: HomePresentation?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter?.viewDidLoad()
    }
}

extension HomeViewController: HomeView {
  
    
    func loadCategories(categoriesList: [CategoryItemViewModel]) {
    
        guard categoriesList.count > 0 else { return }
        
        categoryViews.enumerated().forEach { (index, categoryView) in
            categoryView.configure(
                usingViewModel: categoriesList[index],
                onComplete: { [weak self] (imageName) in
                    self?.presenter?.onFetchThumbnail(imageName: imageName) { image in
                        DispatchQueue.main.async {
                            categoryView.updateImage(image: image)
                        }
                    }
                },
                categorySelectionHandler: { (categoryId, title, description) in
                    print("Category id = \(categoryId), title = \(title)")
                    self.presenter?.onCategorySelection(usingCategory: (id: categoryId, title: title, description: description))
            })
        }
    }
}

