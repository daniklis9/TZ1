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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        titleName.textColor = .white
        subtitleName.textColor = .white
        priceAndGramsLabel.textColor = .white
        self.layer.cornerRadius = 15
        self.mainView.backgroundColor = .black
        // Initialization code
    }

}
