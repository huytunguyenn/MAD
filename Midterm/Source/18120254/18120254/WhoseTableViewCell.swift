//
//  WhoseTableViewCell.swift
//  18120254
//
//  Created by HUYTU on 11/22/20.
//  Copyright © 2020 HUYTU. All rights reserved.
//

import UIKit

class WhoseTableViewCell: UITableViewCell {

    @IBOutlet weak var guestNameLabel: UILabel!
    @IBOutlet weak var guestsLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
