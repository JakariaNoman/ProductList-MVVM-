//
//  ProductCell.swift
//  Prouduct List
//
//  Created by Jakaria Noman on 11/1/25.
//

import UIKit

class ProductCell: UITableViewCell {

    @IBOutlet weak var productBackgroundView: UIView!
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var productTitleLabel: UILabel!
    @IBOutlet weak var productCategoryLabel: UILabel!
    @IBOutlet weak var rateLabel: UIButton!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    var newProductObserver : ProductInfo? {
        didSet {
            productDeatilConfiguration()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        //Cell UI Part Handle here
        productBackgroundView.clipsToBounds = false
        productBackgroundView?.layer.cornerRadius = 15
        productImageView.layer.cornerRadius = 10 //productImageView.frame.height / 8
        self.productBackgroundView.backgroundColor = .systemGray6
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func productDeatilConfiguration() {
        guard let newProductObserver else { return }
        productTitleLabel.text = newProductObserver.title
        productCategoryLabel.text = newProductObserver.category
        
        rateLabel.setTitle("\(newProductObserver.rating.rate)", for: .normal)
        
        descriptionLabel.text = newProductObserver.description
        priceLabel.text = "$\(newProductObserver.price)"
        productImageView.setImage(with: newProductObserver.image)
    }
    
}
