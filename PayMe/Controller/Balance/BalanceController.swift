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
    
    var trip: Trip?
    var travellersTV: TravellersBalanceTVController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // set travellers data in the tableview
        self.travellersTV = TravellersBalanceTVController(tv: travellersTableView, trip: self.trip!)
    }

}
