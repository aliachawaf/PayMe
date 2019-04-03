//
//  ListExpenseViewController.swift
//  PayMe
//
//  Created by Alia Chawaf on 03/04/2019.
//  Copyright © 2019 Chawaf Alia & Gestin Rémi. All rights reserved.
//

import UIKit

class ListExpenseViewController: UIViewController {

    @IBOutlet weak var expenseTV: UITableView!
    
    var expenseTVController: ExpenseTVController!
    var trip: Trip?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.expenseTVController = ExpenseTVController(tv: expenseTV, trip: trip!)
        self.expenseTVController.viewController = self
        
    }
    
}
