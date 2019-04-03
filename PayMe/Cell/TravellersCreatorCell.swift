//
//  TravellersCreatorCell.swift
//  PayMe
//
//  Created by Alia Chawaf on 03/04/2019.
//  Copyright © 2019 Chawaf Alia & Gestin Rémi. All rights reserved.
//

import UIKit

class TravellersCreatorCell: UITableViewCell {


    @IBOutlet weak var amount: UITextField!
    
    @IBOutlet weak var nametraveller: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.amount.textAlignment = .right
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
