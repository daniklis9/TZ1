//
//  TableViewCell.swift
//  TZ1
//
//  Created by Даниил on 26.11.22.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    @IBOutlet private weak var dayLabel: UILabel!
    @IBOutlet private weak var amTemperatureLabel: UILabel!
    @IBOutlet private weak var pmTemperatureLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setupCell(amTemperature: String, pmTemperature: String, day: String) {
        amTemperatureLabel.text = amTemperature
        pmTemperatureLabel.text = pmTemperature
        dayLabel.text = day
    }
}
