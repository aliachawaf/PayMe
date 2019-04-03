//
//  TravellersCreatorTVController.swift
//  PayMe
//
//  Created by Alia Chawaf on 02/04/2019.
//  Copyright © 2019 Chawaf Alia & Gestin Rémi. All rights reserved.
//

import UIKit

class TravellersCreatorTVController: NSObject, UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate {

    

    var travellerTV: UITableView!
    var trip: Trip
    var travellerViewModel: TravellerViewModel
    var viewController: NewExpenseController?
    let fetchResultController : TravellerFetchResultsController
    
    var tabAmountCreator: [Double] = []
    
    init(tv: UITableView!, trip: Trip) {
        
        self.travellerTV = tv
        self.trip = trip
        self.fetchResultController = TravellerFetchResultsController(view: travellerTV, trip: self.trip)
        self.travellerViewModel = TravellerViewModel(data: self.fetchResultController.travellersFetched)
        super.init()
        self.travellerTV.dataSource = self
        self.travellerTV.delegate = self
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return travellerViewModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Fetch a cell of the appropriate type.
        let cell = travellerTV.dequeueReusableCell(withIdentifier: "cellType", for: indexPath) as? TravellersCreatorCell
        
        // Configure the cell’s contents
        cell!.nametraveller.text = self.travellerViewModel.get(travellerAt: indexPath.row)?.fullname()
        
        cell!.amount.placeholder = "0"
        cell!.amount.keyboardType = .numbersAndPunctuation
        cell!.amount.delegate = self
        cell!.amount.tag = indexPath.row
        cell!.selectionStyle = UITableViewCell.SelectionStyle.none
        
        self.tabAmountCreator.append(0.0)
        
        return cell!
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        // hide keybord
        textField.resignFirstResponder()
        
        
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        let index = IndexPath(row: textField.tag, section: 0)
        let cell = travellerTV.cellForRow(at: index) as? TravellersCreatorCell
        
        
        if textField.text == "0" || textField.text == "" {
            cell?.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            textField.placeholder = "0"
            textField.text = ""
            
        } else {
            cell?.backgroundColor = #colorLiteral(red: 0.9764705896, green: 0.9316896746, blue: 0.7069338469, alpha: 1)
        }
        
        self.tabAmountCreator[index.row] = Double(textField.text!) ?? 0.0
        self.viewController!.totalAmount.text = String(tabAmountCreator.reduce(0, +))
        self.viewController!.travellerTVController.updateRepartition()
        
        print(self.tabAmountCreator)
    }
    /*
    func updateTravellersConcernedTV (at indexPath: IndexPath, isCreator: Bool) {
        
        let cell = self.viewController!.travellerConcernedTV.cellForRow(at: indexPath)!
        
        if (isCreator) {
            cell.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
            cell.accessoryType = .none
            cell.selectionStyle = UITableViewCell.SelectionStyle.none
            cell.isUserInteractionEnabled = false
            let currentTraveller = self.travellerViewModel.get(travellerAt: indexPath.row)!
            self.viewController!.travellerTVController.travellersConcerned.append(currentTraveller)
            
        } else {
            cell.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            cell.selectionStyle = UITableViewCell.SelectionStyle.default
            cell.isUserInteractionEnabled = true
        }
 
        
        
    }*/
    
    
}
    
   

