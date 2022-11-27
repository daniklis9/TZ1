//
//  TodayWeatherCell.swift
//  TZ1
//
//  Created by Даниил on 26.11.22.
//

import UIKit

class TodayWeatherCell: UICollectionViewCell {
    
    @IBOutlet private weak var dayLabel: UILabel!
    @IBOutlet private weak var temperatureLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setupCell(day: String, temperature: String){
        dayLabel.text = day
        temperatureLabel.text = temperature
    }
}
