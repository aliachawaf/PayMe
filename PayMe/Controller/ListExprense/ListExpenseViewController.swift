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
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetailsExpense"{
            if let destController = segue.destination as? DetailsExpenseController {
                
                if let cell = sender as? UITableViewCell {
                    guard let index = self.expenseTV.indexPath(for: cell) else {return}
                    destController.expense = self.expenseTVController.expenseViewModel.get(expenseAt: index.row)
                    
                }
            }
        }
    }
    
}
