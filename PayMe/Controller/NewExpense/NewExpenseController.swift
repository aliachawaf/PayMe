//
//  NewExpenseController.swift
//  PayMe
//
//  Created by Alia Chawaf on 01/04/2019.
//  Copyright © 2019 Chawaf Alia & Gestin Rémi. All rights reserved.
//

import UIKit

class NewExpenseController: UIViewController {
    
    
    
    @IBOutlet weak var travellerPV: UIPickerView!
    @IBOutlet weak var travellerTV: UITableView!
    
    var travellerPVController: TravellerExpensePickerViewController!
    var travellerTVController: TravellerExpenseTableViewController!
    var trip: Trip?
    
    
    override func viewDidLoad() {
        self.travellerPVController = TravellerExpensePickerViewController(pv: travellerPV, trip: trip!)
        
        self.travellerTVController = TravellerExpenseTableViewController(tv: travellerTV, trip: trip!)
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "okAddExpense" {
            
        } else {
            
        }
    }

}
