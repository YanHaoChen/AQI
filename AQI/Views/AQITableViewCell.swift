//
//  AQITableViewCell.swift
//  AQI
//
//  Created by sean on 2019/5/8.
//  Copyright © 2019 sean. All rights reserved.
//

import UIKit

class AQITableViewCell: UITableViewCell {

    @IBOutlet weak var siteName: UILabel!
    @IBOutlet weak var AQIValue: UILabel!
    @IBOutlet weak var statusValue: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
