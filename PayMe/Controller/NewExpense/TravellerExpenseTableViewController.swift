//
//  TravellerExpenseTableViewController.swift
//  PayMe
//
//  Created by Alia Chawaf on 01/04/2019.
//  Copyright © 2019 Chawaf Alia & Gestin Rémi. All rights reserved.
//

import UIKit

class TravellerExpenseTableViewController: NSObject, UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate {
    
    var travellerTV: UITableView!
    var trip: Trip
    var travellerViewModel: TravellerViewModel
    var viewController: NewExpenseController?
    let fetchResultController : TravellerFetchResultsController
    var amountConcerned: [Double] = []
    
    var nbTravellersConcerned: Int = 0
    
    init(tv: UITableView!, trip: Trip) {
        
        self.travellerTV = tv
        self.trip = trip
        self.fetchResultController = TravellerFetchResultsController(view: travellerTV, trip: trip)
        self.travellerViewModel = TravellerViewModel(data: self.fetchResultController.travellersFetched)
        
        super.init()
        self.travellerTV.dataSource = self
        self.travellerTV.delegate = self
 

    }
    
  
    // MARK: - TableViewDataSource
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return travellerViewModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Fetch a cell of the appropriate type.
        let cell = travellerTV.dequeueReusableCell(withIdentifier: "cellTypeIdentifier", for: indexPath) as! TravellersConcernedCell
        
        // Configure the cell’s contents
        cell.nametraveller.text = self.travellerViewModel.get(travellerAt: indexPath.row)?.fullname()
        cell.amount.placeholder = "0"
        cell.amount.delegate = self
        
        cell.accessoryType = .checkmark
        cell.tintColor = #colorLiteral(red: 0.5725490451, green: 0, blue: 0.2313725501, alpha: 1)
        
        let backgroundView = UIView()
        backgroundView.backgroundColor = #colorLiteral(red: 0.9764705896, green: 0.9316896746, blue: 0.7069338469, alpha: 1)
        cell.selectedBackgroundView = backgroundView
        
        self.nbTravellersConcerned = self.nbTravellersConcerned + 1
        self.amountConcerned.append(0.0)
        
        return cell
    }

   
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        let cell = tableView.cellForRow(at: indexPath as IndexPath) as! TravellersConcernedCell
            
            cell.amount.placeholder = "0.0"
                
                if cell.accessoryType == .checkmark{
                    cell.accessoryType = .none
                    self.nbTravellersConcerned = nbTravellersConcerned - 1
                    cell.amount.text = ""
                    cell.amount.isEnabled = false
                    updateRepartition()
                }
                else{
                    cell.accessoryType = .checkmark
                    cell.tintColor = #colorLiteral(red: 0.5725490451, green: 0, blue: 0.2313725501, alpha: 1)
                    cell.amount.isEnabled = true
                    self.nbTravellersConcerned = nbTravellersConcerned + 1
                    updateRepartition()
                    
                }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        return "Concerné(s)"
    }
    
    func updateRepartition() {
        let totalAmount = Double(self.viewController!.totalAmount.text!) ?? 0.0
        var cpt = 0
        for cell in self.travellerTV.visibleCells as! [TravellersConcernedCell]{
            if cell.accessoryType == .checkmark {
                
                cell.amount.text = String(totalAmount/Double(self.nbTravellersConcerned))
                self.amountConcerned[cpt] = totalAmount/Double(self.nbTravellersConcerned)
            }
            else {
                self.amountConcerned[cpt] = 0.0
            }
           cpt = cpt + 1
        }
        
        print(self.amountConcerned)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        // hide keybord
        textField.resignFirstResponder()
        
        
        return true
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        
        view.tintColor = #colorLiteral(red: 0.7509321217, green: 0.8862745166, blue: 0.8517355244, alpha: 1)
    }
}

