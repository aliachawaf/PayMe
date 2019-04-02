//
//  NewExpenseController.swift
//  PayMe
//
//  Created by Alia Chawaf on 01/04/2019.
//  Copyright © 2019 Chawaf Alia & Gestin Rémi. All rights reserved.
//

import UIKit

class NewExpenseController: UIViewController {
    
    
    @IBOutlet weak var travellersCreatorsTV: UITableView!
    
    @IBOutlet weak var travellerConcernedTV: UITableView!
    
    
    @IBOutlet weak var totalAmount: UILabel!
    var travellerTVController: TravellerExpenseTableViewController!
    var travellersCreatorTVController: TravellersCreatorTVController!
    var trip: Trip?
    
    
    override func viewDidLoad() {
        
        self.travellersCreatorTVController = TravellersCreatorTVController(tv: travellersCreatorsTV, trip: trip!)
        self.travellersCreatorTVController.viewController = self

        self.travellerTVController = TravellerExpenseTableViewController(tv: travellerConcernedTV, trip: trip!)
    
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "okAddExpense" {
            
        } else {
            
        }
    }

}
