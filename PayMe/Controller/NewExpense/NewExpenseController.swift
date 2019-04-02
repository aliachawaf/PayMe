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
    
    @IBOutlet weak var nameExpense: UITextField!
    @IBOutlet weak var imageExpense: UIImageView!
    
    @IBOutlet weak var dateExpense: UIDatePicker!
    @IBOutlet weak var totalAmount: UILabel!
    var travellerTVController: TravellerExpenseTableViewController!
    var travellersCreatorTVController: TravellersCreatorTVController!
    
    var trip: Trip?
    var  newExpense: Expense?
    
    override func viewDidLoad() {
        
        self.travellersCreatorTVController = TravellersCreatorTVController(tv: travellersCreatorsTV, trip: trip!)
        self.travellersCreatorTVController.viewController = self

        self.travellerTVController = TravellerExpenseTableViewController(tv: travellerConcernedTV, trip: trip!)
        self.travellerTVController.viewController = self
        
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "okAddExpense" {
            
            let name = self.nameExpense.text!
            let imageData = self.imageExpense.image!.jpegData(compressionQuality: 1)!
            let date: Date = self.dateExpense.date
            
            let travellers = self.travellerTVController.travellerViewModel.getAll()!
            let amountCreator = self.travellersCreatorTVController.tabAmountCreator
            let amountConcerned = self.travellerTVController.amountConcerned
            
            self.newExpense = Expense(name: name, image: imageData, date: date, travellers: travellers, amountCreator: amountCreator, amountDept: amountConcerned)
            
            print("\(self.newExpense)")
            
        }
        else {
            
            
        }
    }

}
