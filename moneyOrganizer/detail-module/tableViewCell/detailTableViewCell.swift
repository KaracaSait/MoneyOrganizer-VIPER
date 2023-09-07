//
//  detailTableViewCell.swift
//  moneyOrganizer
//
//  Created by Sait KARACA on 7.09.2023.
//

import UIKit

class detailTableViewCell: UITableViewCell {

    @IBOutlet weak var tableViewImage: UIImageView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var transactionLabel: UILabel!
    @IBOutlet weak var explanationLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
