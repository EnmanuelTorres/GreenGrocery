//
//  HomeViewController.swift
//  GreenGrocery
//
//  Created by ENMANUEL TORRES on 15/04/24.
//

import UIKit

protocol HomeView: AnyObject{
    func updateGroceries(groceriesList: [GroceryItemViewModel]) -> Void
}

class HomeViewController: UIViewController {
    
    
    @IBOutlet weak var tableView: UITableView!
    
    private static let groceryCellID = "groceryCellID"
    
    var dataSource: [GroceryItemViewModel] = [] {
        
        didSet {
            self.tableView.reloadData()
        }
    }
    
    lazy var custom : customView = {
        let control = customView()
        let viewModel = AddBagViewModel(id: "22", title: "Add to Bag", stepValue: 0)
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
        self.tableView.register(UINib(nibName: "GroceryItemCell", bundle: nil), forCellReuseIdentifier: HomeViewController.groceryCellID)
        self.tableView.dataSource = self
        self.tableView.delegate = self
    }


}

extension HomeViewController: HomeView {
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
