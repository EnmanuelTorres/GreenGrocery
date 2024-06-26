//
//  myViewController.swift
//  GreenGrocery
//
//  Created by ENMANUEL TORRES on 5/05/24.
//

import UIKit

typealias BagClosure = ((skuId: String, stepValue: Int)) -> ()

//@IBDesignable
class customView: UIView {


    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var plusButton: UIButton!
    
    @IBOutlet weak var minusButton: UIButton!
    
    @IBOutlet weak var stepLabel: UILabel!
    
    var closure: BagClosure?
    
    var viewModel: CartValueViewModel! {
        
        didSet {
            stepLabel.text = "\(viewModel.stepValue)"
            addButton.isHidden = (viewModel.showStepper)
            plusButton.isHidden = !(viewModel.showStepper)
            minusButton.isHidden = !(viewModel.showStepper)
            stepLabel.isHidden = !(viewModel.showStepper)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUp()
    }
    
    func setUp(){
        guard let view = self.loadFromNib(nibName: "AddBagControl") else {return }
        backgroundColor = .clear
        view.frame = self.bounds
        self.addSubview(view)
    }
    
    func configure(usingViewModel viewModel: CartValueViewModel, bagClosure: @escaping BagClosure) -> Void {
        self.viewModel = viewModel
        self.addButton.setTitle(viewModel.title, for: .normal)
        self.closure = bagClosure
    }
    
    @IBAction func addToBag(_ sender: Any) {
        self.viewModel = viewModel?.onAddToBag()
        closure?((viewModel.id, viewModel.stepValue))
    }
    
    @IBAction func incrementButton(_ sender: Any) {
        self.viewModel = viewModel?.onIncrement()
        closure?((viewModel.id, viewModel.stepValue))
    }
    
    @IBAction func decrementButton(_ sender: Any) {
        self.viewModel = viewModel?.onDecrement()
        closure?((viewModel.id, viewModel.stepValue))
    }
}

extension UIView {
     func loadFromNib(nibName: String) -> UIView? {
       let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: nibName, bundle: bundle)
         return nib.instantiate(withOwner: self, options: nil).first as? UIView
    }
}


struct CartValueViewModel {
    let id: String
    let title: String
    var stepValue: Int
    var showStepper: Bool
    
    init(id: String, stepValue: Int) {
        self.id = id
        self.title = "Add to Bag"
        self.stepValue = stepValue
        self.showStepper = (stepValue > 0)
    }
}

extension CartValueViewModel {
    
    func onAddToBag() -> CartValueViewModel {
        return CartValueViewModel(id: id, stepValue: 1)
    }
    
    func onIncrement() -> CartValueViewModel {
        guard stepValue < 10 else { return self }
        return CartValueViewModel(id: id, stepValue: stepValue + 1)
    }
    
    func onDecrement() -> CartValueViewModel {
        guard stepValue > 0 else { return self }
        return CartValueViewModel(id: id, stepValue: stepValue - 1)
    }
}
