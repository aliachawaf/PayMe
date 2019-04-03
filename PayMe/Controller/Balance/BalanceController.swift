//
//  BalanceController.swift
//  PayMe
//
//  Created by Alia Chawaf on 03/04/2019.
//  Copyright © 2019 Chawaf Alia & Gestin Rémi. All rights reserved.
//

import UIKit

class BalanceController: UIViewController {

 
    @IBOutlet weak var travellersTableView: UITableView!
    
    @IBOutlet weak var refundTableView: UITableView!
    
    var trip: Trip?
    var travellersTVController: TravellersBalanceTVController!
    var refundTVController: RefundTVController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // set travellers data in the tableview
        self.travellersTVController = TravellersBalanceTVController(tv: travellersTableView, trip: self.trip!)
     
        self.refundTVController = RefundTVController(tv: refundTableView, trip: self.trip!)
    }

}
