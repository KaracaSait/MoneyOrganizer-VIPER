//
//  homepageTableViewCell.swift
//  moneyOrganizer
//
//  Created by Sait KARACA on 6.09.2023.
//

import UIKit

class homepageTableViewCell: UITableViewCell {

    @IBOutlet weak var tableViewImage: UIImageView!
    @IBOutlet weak var accountLabel: UILabel!
    @IBOutlet weak var moneyLabel: UILabel!
    @IBOutlet weak var processLabel: UILabel!
    @IBOutlet weak var process1: UILabel!
    @IBOutlet weak var process2: UILabel!
    @IBOutlet weak var price1: UILabel!
    @IBOutlet weak var price2: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
