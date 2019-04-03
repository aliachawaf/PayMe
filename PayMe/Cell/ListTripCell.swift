//
//  ListTripCell.swift
//  PayMe
//
//  Created by Alia Chawaf on 03/04/2019.
//  Copyright © 2019 Chawaf Alia & Gestin Rémi. All rights reserved.
//

import UIKit

class ListTripCell: UITableViewCell {

    @IBOutlet weak var amount: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.amount.layer.cornerRadius = 8
        self.amount.layer.masksToBounds = true
        self.amount.textAlignment = .center
        self.amount.backgroundColor = #colorLiteral(red: 0.7509321217, green: 0.8862745166, blue: 0.8517355244, alpha: 1)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
