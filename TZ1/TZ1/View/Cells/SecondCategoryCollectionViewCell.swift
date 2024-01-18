//
//  SecondCategoryCollectionViewCell.swift
//  TZ1
//
//  Created by Даниил on 2024/01/16.
//

import UIKit

class SecondCategoryCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var titleName: UILabel!
    @IBOutlet weak var subtitleName: UILabel!
    @IBOutlet weak var priceAndGramsLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var spicyImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        titleName.textColor = .white
        subtitleName.textColor = .white
        priceAndGramsLabel.textColor = .white
        self.layer.cornerRadius = 15
        self.mainView.backgroundColor = .black
        imageView.contentMode = .scaleToFill
        // Initialization code
    }
    
    func setupImage(image: UIImage) {
        self.imageView.image = image
    }
    
    func setupLabels(titleName: String, subTitleName: String, priceAndGrams: String) {
        self.titleName.text = titleName
        self.subtitleName.text = subTitleName
        self.priceAndGramsLabel.text = priceAndGrams
    }
    
    func setupSpicyImage(image: UIImage?) {
        self.spicyImage.image = image
    }

}
