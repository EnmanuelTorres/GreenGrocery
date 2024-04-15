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
    
    var presenter: HomePresentation!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter.viewDidLoad()
        view.backgroundColor = .blue
     
    }


}

extension HomeViewController: HomeView {
    func updateTitle(title: String) {
          helloLabel.text = title
    }
    
    
}
