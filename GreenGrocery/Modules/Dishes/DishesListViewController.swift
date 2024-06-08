//
//  DishesListViewController.swift
//  GreenGrocery
//
//  Created by ENMANUEL TORRES on 1/06/24.
//

import UIKit

protocol DishesListView: NSObject {
    func updateCoverTitle(title: String) -> Void
    func updateGroceries(groceriesList: [DishItemViewModel]) -> Void
    func updateCoverImage(image: UIImage) -> Void
}

class DishesListViewController: UIViewController {

    
    @IBOutlet weak var categoryImageView: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var coverDescriptionLabel: UILabel!
    @IBOutlet weak var coverHeightConstraint: NSLayoutConstraint!
    private static let groceryCellID = "groceryCellID"
    
    var isCoverHidden: Bool = false
    
    lazy var vm = CoverImageHeightViewModel(currentOffset: tableView.contentOffset.y, previousOffset: 0, coverHeight: coverHeightConstraint.constant)
    
    var presenter: DishesListPresenter?
    var datasource: [DishItemViewModel] = [] {
        
        didSet {
            self.tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(UINib(nibName: "GroceryItemCell", bundle: nil), forCellReuseIdentifier: DishesListViewController.groceryCellID)
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.estimatedRowHeight = 100
        self.tableView.rowHeight = UITableView.automaticDimension
        self.presenter?.viewDidLoad()
      
    }
}

extension DishesListViewController: DishesListView {
    func updateCoverTitle(title: String) {
        self.coverDescriptionLabel.text = title
    }
    
    func updateGroceries(groceriesList: [DishItemViewModel]) {
        self.datasource = groceriesList
    }
    
    func updateCoverImage(image: UIImage) {
        categoryImageView.image = image
    }
    
}

extension DishesListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datasource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let viewModel = datasource[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: DishesListViewController.groceryCellID, for: indexPath) as! GroceryItemCell
        cell.configure(usingViewModel: viewModel)
        
        self.presenter?.onThumnailUpdate(imageName: viewModel.image) { image in
            DispatchQueue.main.async {
                let updateCell = tableView.cellForRow(at: indexPath)
                if updateCell != nil {
                    cell.updateGroceryIcon(image: image)
                }
            }
        }
        return cell
    }
    
}

extension DishesListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let heightVm = vm.updateHeight(offset: scrollView.contentOffset.y)
        coverHeightConstraint.constant = heightVm.coverHeight
    }
}

struct CoverImageHeightViewModel {
    let currentOffset: CGFloat
    let previousOffset: CGFloat
    let coverHeight: CGFloat
}

extension CoverImageHeightViewModel {
    
    func updateHeight(offset: CGFloat) -> CoverImageHeightViewModel {
        
        if offset > 200 {
            return CoverImageHeightViewModel(currentOffset: offset, previousOffset: self.currentOffset, coverHeight: 0)
        }
        
        let offsetDiff = self.previousOffset - offset
        let newHeight = self.coverHeight + offsetDiff
        
        return CoverImageHeightViewModel(currentOffset: offset, previousOffset: self.currentOffset, coverHeight: newHeight)
    }
}
