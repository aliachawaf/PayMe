//
//  ConcernedTVController.swift
//  PayMe
//
//  Created by Alia Chawaf on 03/04/2019.
//  Copyright © 2019 Chawaf Alia & Gestin Rémi. All rights reserved.
//

import UIKit

class ConcernedTVController: NSObject, UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate {

    var expense: Expense?
    var travellerTV: UITableView!
    
    lazy var concerned: [Traveller] = {
        
        var result: [Traveller] = []
        
        for i in 0 ..< self.expense!.amountDebt.count {
            
            if self.expense!.amountDebt[i] != 0.0 {
                result.append((self.expense?.travellers[i])!)
            }
        }
        
        return result
    }()
    
    lazy var amountsOnlyConcerned: [Double] = {
        
        return self.expense!.amountDebt.filter({$0 != 0.0})
        
    }()
    
    
    init(tv: UITableView!, expense: Expense) {
        
        self.travellerTV = tv
        self.expense = expense
        super.init()
        self.travellerTV.dataSource = self
        self.travellerTV.delegate = self
    }
    
    
    //-------------------------------------------------------------------------------------------------
    // MARK: - TableViewDataSource
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        var result = 0
        
        for a in expense!.amountDebt {
            if a != 0.0 {
                result = result + 1
            }
        }
        
        return result
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Fetch a cell of the appropriate type.
        let cell = travellerTV.dequeueReusableCell(withIdentifier: "cellTypeIdentifier", for: indexPath) as! ConcernedByAnExpenseCell
        
        // Configure the cell’s contents
        cell.nametraveller.text = self.concerned[indexPath.row].fullname()
        cell.amount.text = String(self.amountsOnlyConcerned[indexPath.row]) + " €"
        
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        
        return cell
    }

    //-------------------------------------------------------------------------------------------------
    // MARK: - TableViewDelegate
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        return "Voyageur(s) endetté(s)"
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        
        view.tintColor = #colorLiteral(red: 0.7509321217, green: 0.8862745166, blue: 0.8517355244, alpha: 1)
    }
}
