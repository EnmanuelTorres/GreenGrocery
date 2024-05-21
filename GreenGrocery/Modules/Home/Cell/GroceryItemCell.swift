//
//  GroceryItemCell.swift
//  GreenGrocery
//
//  Created by ENMANUEL TORRES on 11/05/24.
//

import UIKit

class GroceryItemCell: UITableViewCell {
    
    @IBOutlet weak var productImageView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var detailsLabel: UILabel!
    
    @IBOutlet weak var priceLabel: UILabel!
    
    @IBOutlet weak var addToBagControl: customView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(usingViewModel viewModel: GroceryItemViewModel, addToCartClosure: @escaping BagClosure) -> Void {
        self.titleLabel.text = viewModel.title
        self.detailsLabel.text = viewModel.details
        self.productImageView.image = UIImage(named: viewModel.image)
        self.priceLabel.text = viewModel.price
        self.selectionStyle = .none
        addToBagControl.configure(usingViewModel: viewModel.cartValue, bagClosure: addToCartClosure)
        
    }
    
}
