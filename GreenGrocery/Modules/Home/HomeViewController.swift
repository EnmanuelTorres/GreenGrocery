//
//  HomeViewController.swift
//  GreenGrocery
//
//  Created by ENMANUEL TORRES on 15/04/24.
//

import UIKit

protocol HomeView: AnyObject{
    func updateGroceries(groceriesList: [GroceryItemViewModel]) -> Void
    func loadCategories(categoriesList: [CategoryItemViewModel]) -> ()
}

class HomeViewController: UIViewController {
    
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var topCategoryView: CategoryView!
    
    @IBOutlet weak var leftTopCategoryView: CategoryView!
    
    @IBOutlet weak var leftBottomCategoryView: CategoryView!
    
    @IBOutlet weak var rightCategoryView: CategoryView!
    
    private static let groceryCellID = "groceryCellID"
    
    var dataSource: [GroceryItemViewModel] = [] {
        
        didSet {
            self.tableView.reloadData()
        }
    }
    
    lazy var custom : customView = {
        let control = customView()
        let viewModel = CartValueViewModel(id: "22", stepValue: 0)
        control.configure(usingViewModel: viewModel, bagClosure: { stepValue in
            print("este es el stepValue \(stepValue)")
        })
        return control
        
    }()
    var presenter: HomePresentation!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter.viewDidLoad()
      
        setupCounterView()
    }
    
    private func setupCounterView() {
     //   containerStackView.addArrangedSubview(custom)
        /// Todo - Move the tableview logic to groceries listing screen
     //   self.tableView.register(UINib(nibName: "GroceryItemCell", bundle: nil), forCellReuseIdentifier: HomeViewController.groceryCellID)
     //   self.tableView.dataSource = self
     //   self.tableView.delegate = self
    }


}

extension HomeViewController: HomeView {
    func loadCategories(categoriesList: [CategoryItemViewModel]) {
        topCategoryView.configure(usingViewModel: categoriesList[0]) { [weak self] (imageName) in
            self?.presenter?.onFetchThumbnail(imageName: imageName) { data in
                guard let image = UIImage(data: data) else { return }
                DispatchQueue.main.async {
                    self?.topCategoryView.updateImage(image: image)
                }
            }
        }
        
        leftTopCategoryView.configure(usingViewModel: categoriesList[1]) { [weak self] (imageName) in
            self?.presenter?.onFetchThumbnail(imageName: imageName) { data in
                guard let image = UIImage(data: data) else { return }
                DispatchQueue.main.async {
                    self?.leftTopCategoryView.updateImage(image: image)
                }
            }
        }
        
        leftBottomCategoryView.configure(usingViewModel: categoriesList[2]) { [weak self] (imageName) in
            self?.presenter?.onFetchThumbnail(imageName: imageName) { data in
                guard let image = UIImage(data: data) else { return }
                DispatchQueue.main.async {
                    self?.leftBottomCategoryView.updateImage(image: image)
                }
            }
        }
        
        rightCategoryView.configure(usingViewModel: categoriesList[3]) { [weak self] (imageName) in
            self?.presenter?.onFetchThumbnail(imageName: imageName) { data in
                guard let image = UIImage(data: data) else { return }
                DispatchQueue.main.async {
                    self?.rightCategoryView.updateImage(image: image)
                }
            }
        }
        
       
    }
    
    func updateGroceries(groceriesList: [GroceryItemViewModel]) {
    
        self.dataSource = groceriesList
       
    }
    
}

extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let viewModel = dataSource[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: HomeViewController.groceryCellID, for: indexPath) as! GroceryItemCell
        
        cell.configure(usingViewModel: viewModel) { result in
            print("Cart item added with sku = \(result.skuId) and quantity = \(result.stepValue)")
            let skuItem: SkuItem = (skuId: result.skuId, quantity: result.stepValue)
            self.presenter?.onAddToCart(skuItem: skuItem)
        }
        return cell
    }
}


extension HomeViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    
}
