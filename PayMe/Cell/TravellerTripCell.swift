//
//  TravellerTripCell.swift
//  PayMe
//
//  Created by Alia Chawaf on 03/04/2019.
//  Copyright © 2019 Chawaf Alia & Gestin Rémi. All rights reserved.
//

import UIKit

class TravellerTripCell: UITableViewCell {

    @IBOutlet weak var balance: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.balance.layer.cornerRadius = 8
        self.balance.layer.masksToBounds = true
        self.balance.textAlignment = .center
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
