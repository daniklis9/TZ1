//
//  CategoryCollectionViewCell.swift
//  TZ1
//
//  Created by Даниил on 2024/01/15.
//

import UIKit

class CategoryCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var categoryName: UILabel!
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var goodsQuantity: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.cornerRadius = 15
        self.mainView.backgroundColor = UIColor.darkGray
        self.categoryName.textColor = .white
        self.categoryName.font = .boldSystemFont(ofSize: 14)
        self.goodsQuantity.textColor = .white
    }
    
    func setupImage(image: UIImage) {
        imageView.image = image
    }


}
