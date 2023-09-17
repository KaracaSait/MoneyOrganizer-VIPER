//
//  exchangeRateTableViewCell.swift
//  moneyOrganizer
//
//  Created by Sait KARACA on 17.09.2023.
//

import UIKit

class exchangeRateTableViewCell: UITableViewCell {

    @IBOutlet weak var rateName: UILabel!
    @IBOutlet weak var ratePrice: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
