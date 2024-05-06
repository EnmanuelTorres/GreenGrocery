//
//  HomeViewController.swift
//  GreenGrocery
//
//  Created by ENMANUEL TORRES on 15/04/24.
//

import UIKit

protocol HomeView: AnyObject{
    func updateTitle(title: String)
}

class HomeViewController: UIViewController {

    @IBOutlet weak var helloLabel: UILabel!
    

    @IBOutlet weak var containerStackView: UIStackView!
    
    
    
    lazy var custom : customView = {
        let control = customView()
        let viewModel = AddBagViewModel(id: "22", title: "Add to Bag", stepValue: 0)
        control.viewModel = viewModel
       
        return control
        
    }()
    var presenter: HomePresentation!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter.viewDidLoad()
        view.backgroundColor = .red
      
        setupCounterView()
    }
    
    private func setupCounterView() {
        containerStackView.addArrangedSubview(custom)
    }


}

extension HomeViewController: HomeView {
    func updateTitle(title: String) {
        helloLabel.text = title
    }
    
    
}

