//
//  CreatorsOfExpenseTVController.swift
//  PayMe
//
//  Created by Alia Chawaf on 03/04/2019.
//  Copyright © 2019 Chawaf Alia & Gestin Rémi. All rights reserved.
//

import UIKit

class CreatorsOfExpenseTVController: NSObject, UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate {


    var expense: Expense?
    var travellerTV: UITableView!
    
    lazy var creators: [Traveller] = {
        
        var result: [Traveller] = []
        
        for i in 0 ..< self.expense!.amountCreator.count {
            
            if self.expense!.amountCreator[i] != 0.0 {
                result.append((self.expense?.travellers[i])!)
            }
        }
        
        return result
    }()
    
    lazy var amountsOnlyCreators: [Double] = {
        
        return self.expense!.amountCreator.filter({$0 != 0.0})
       
    }()

    
    init(tv: UITableView!, expense: Expense) {
        
        self.travellerTV = tv
        self.expense = expense
        super.init()
        self.travellerTV.dataSource = self
        self.travellerTV.delegate = self
    }
   
    
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        var result = 0
        
        for a in expense!.amountCreator {
            if a != 0.0 {
                result = result + 1
            }
        }
        
        return result
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Fetch a cell of the appropriate type.
        let cell = travellerTV.dequeueReusableCell(withIdentifier: "cellType", for: indexPath) as! CreatorOfAnExpenseCell
        
        // Configure the cell’s contents
        cell.nametraveller.text = self.creators[indexPath.row].fullname()
        cell.amount.text = String(self.amountsOnlyCreators[indexPath.row]) + " €"
        
        cell.selectionStyle = UITableViewCell.SelectionStyle.none

        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        return "Voyageur(s) dépensier(s)"
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        
        view.tintColor = #colorLiteral(red: 0.7509321217, green: 0.8862745166, blue: 0.8517355244, alpha: 1)
    }
}
