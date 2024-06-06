//
//  CategoryView.swift
//  GreenGrocery
//
//  Created by ENMANUEL TORRES on 15/04/24.
//

import UIKit

fileprivate let categoryViewNibName = "CategoryView"

typealias CategorySelectionHandler = (_ categoryId: Int, _ title: String, _ description: String) -> Void

class CategoryView: UIView, ViewLoadable {
    static var nibName: String = categoryViewNibName
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var details: UILabel!
    
    var viewModel: CategoryItemViewModel?
    var handler: CategorySelectionHandler?
    
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
    func configure(usingViewModel viewModel: CategoryItemViewModel,
                   onComplete: (_ imageName: String) -> (),
                   categorySelectionHandler: @escaping CategorySelectionHandler) -> Void {
        self.viewModel = viewModel
        title.text = viewModel.title.uppercased()
        details.text = viewModel.details
        onComplete(viewModel.imageName)
        self.handler = categorySelectionHandler
    }
    
    /// UpdateImage
    ///
    /// - Parameter image: UIImage
    func updateImage(image: UIImage) -> Void {
        imageView.image = image
    }
    
    @IBAction func onCategoryTap(_ sender: Any) {
        guard let categoryId = viewModel?.id, let title = viewModel?.title, let description = viewModel?.details else { return }
        print("debug: \(title)")
        handler?(categoryId, title, description )
    }
    
}
