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
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    
    func configure(usingViewModel viewModel: DishItemViewModel) -> Void {
        self.titleLabel.text = viewModel.title
        self.detailsLabel.text = viewModel.id
        self.productImageView.image = UIImage(named: "placeholder")
        self.selectionStyle = .none
    }
    
    func updateGroceryIcon(image: UIImage) -> Void {
        self.productImageView.image = image
    }
}

