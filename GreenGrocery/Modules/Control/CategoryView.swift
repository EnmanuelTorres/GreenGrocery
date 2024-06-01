//
//  CategoryView.swift
//  GreenGrocery
//
//  Created by ENMANUEL TORRES on 15/04/24.
//

import UIKit

fileprivate let categoryViewNibName = "CategoryView"

class CategoryView: UIView, ViewLoadable {
    static var nibName: String = categoryViewNibName
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var details: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    init() {
        super.init(frame: CGRect.zero)  // 4.
        commonInit()
    }
    
    private func commonInit() {
        Bundle(for: type(of: self)).loadNibNamed("CategoryView", owner: self, options: nil)
        backgroundColor = .clear
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        contentView.layer.cornerRadius = 5.0
    }
    
    /// Configure using CategoryItemViewModel
    ///
    /// - Parameter viewModel: CategoryItemViewModel
    func configure(usingViewModel viewModel: CategoryItemViewModel, onComplete: (_ imageName: String) -> ()) -> Void {
        title.text = viewModel.title.uppercased()
        details.text = viewModel.details
        onComplete(viewModel.imageName)
    }
    
    /// UpdateImage
    ///
    /// - Parameter image: UIImage
    func updateImage(image: UIImage) -> Void {
        imageView.image = image
    }
}
