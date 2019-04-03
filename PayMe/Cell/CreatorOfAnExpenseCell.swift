//
//  CreatorOfAnExpenseCell.swift
//  PayMe
//
//  Created by Alia Chawaf on 03/04/2019.
//  Copyright © 2019 Chawaf Alia & Gestin Rémi. All rights reserved.
//

import UIKit

class CreatorOfAnExpenseCell: UITableViewCell {

    
    @IBOutlet weak var amount: UILabel!
    @IBOutlet weak var nametraveller: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.amount.layer.cornerRadius = 8
        self.amount.layer.masksToBounds = true
        self.amount.textAlignment = .center
        self.amount.backgroundColor = #colorLiteral(red: 0.9764705896, green: 0.9316896746, blue: 0.7069338469, alpha: 1)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
