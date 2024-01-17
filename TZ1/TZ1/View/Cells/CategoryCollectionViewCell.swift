//
//  CategoryCollectionViewCell.swift
//  TZ1
//
//  Created by Даниил on 2024/01/15.
//

import UIKit

class CategoryCollectionViewCell: UICollectionViewCell {
    @IBOutlet private weak var mainView: UIView!
    @IBOutlet private weak var categoryName: UILabel!
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var goodsQuantity: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.cornerRadius = 15
        self.mainView.backgroundColor = UIColor.darkGray.withAlphaComponent(0.3)
        self.categoryName.textColor = .white
        self.goodsQuantity.textColor = .white
    }
    
    func setupImage(image: UIImage) {
        imageView.image = image
    }
    
    func setCategoryName(name: String) {
        categoryName.text = name
    }
    
    func setGoodsQuantity(quantity: String) {
        goodsQuantity.text = quantity
    }
}
