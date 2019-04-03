//
//  DetailsExpenseController.swift
//  PayMe
//
//  Created by Alia Chawaf on 03/04/2019.
//  Copyright © 2019 Chawaf Alia & Gestin Rémi. All rights reserved.
//

import UIKit

class DetailsExpenseController: UIViewController {

    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var amount: UILabel!
  
    @IBOutlet weak var creatorsTV: UITableView!
    @IBOutlet weak var concernedTV: UITableView!
    
    var creatorsTVController: CreatorsOfExpenseTVController?
    var concernedTVController: ConcernedTVController?
    var expense: Expense?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.name.text = expense?.name
        
        if let dataImage = expense?.image {
            self.imageView.image = UIImage(data: dataImage)
        }
        
        self.date.text = "Date : " + self.expense!.date!.description
        
        self.amount.text = "Montant : " + String(self.expense!.amount) + " €"
        
        self.creatorsTVController = CreatorsOfExpenseTVController(tv: creatorsTV, expense: self.expense!)
        self.concernedTVController = ConcernedTVController(tv: concernedTV, expense: self.expense!)
        
    }
    
    

}
