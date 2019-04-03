//
//  RefundInBalanceCell.swift
//  PayMe
//
//  Created by Alia Chawaf on 03/04/2019.
//  Copyright © 2019 Chawaf Alia & Gestin Rémi. All rights reserved.
//

import UIKit

class RefundInBalanceCell: UITableViewCell {

    var refund: Refund?
    var refundTVController: RefundTVController?
    
    @IBAction func handleRefund(_ sender: Any) {
        
        Expense(refund: refund!)
        self.refundTVController!.travellerTV.reloadData()
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
