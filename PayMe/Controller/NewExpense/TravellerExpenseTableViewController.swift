//
//  TravellerExpenseTableViewController.swift
//  PayMe
//
//  Created by Alia Chawaf on 01/04/2019.
//  Copyright © 2019 Chawaf Alia & Gestin Rémi. All rights reserved.
//

import UIKit

class TravellerExpenseTableViewController: NSObject, UITableViewDataSource, UITableViewDelegate {
    
    var travellerTV: UITableView!
    var trip: Trip
    var travellerViewModel: TravellerViewModel
    var viewController: NewExpenseController?
    let fetchResultController : TravellerFetchResultsController
    
    var travellersConcerned: [Traveller] = []
    
    init(tv: UITableView!, trip: Trip) {
        
        self.travellerTV = tv
        self.trip = trip
        self.fetchResultController = TravellerFetchResultsController(trip: self.trip)
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
        let cell = travellerTV.dequeueReusableCell(withIdentifier: "cellTypeIdentifier", for: indexPath)
        // Configure the cell’s contents
        cell.textLabel!.text = self.travellerViewModel.get(travellerAt: indexPath.row)?.fullname()
        
        cell.accessoryType = .checkmark
        cell.tintColor = #colorLiteral(red: 0.5725490451, green: 0, blue: 0.2313725501, alpha: 1)
        self.travellersConcerned.append(self.travellerViewModel.get(travellerAt: indexPath.row)!)
        
      //  let indexTravellerCreator = self.viewController?.travellerPV.selectedRow(inComponent: 0)
     /*
        if indexPath.row == indexTravellerCreator {
            cell.backgroundColor = #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1)
        }
       */
        return cell
    }

   
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if let cell = tableView.cellForRow(at: indexPath as IndexPath) {
            
          //  let indexTravellerCreator = self.viewController?.travellerPV.selectedRow(inComponent: 0)
            
          //  if (indexPath.row != indexTravellerCreator) {
            
                let currentTraveller: Traveller = self.travellerViewModel.get(travellerAt: indexPath.row)!
                
                if cell.accessoryType == .checkmark{
                    cell.accessoryType = .none
                   
                    let index: Int = self.travellersConcerned.lastIndex(of: currentTraveller)!
                    self.travellersConcerned.remove(at: index)
                }
                else{
                    cell.accessoryType = .checkmark
                    cell.tintColor = #colorLiteral(red: 0.5725490451, green: 0, blue: 0.2313725501, alpha: 1)
                    self.travellersConcerned.append(currentTraveller)
                }
          /*  } else {
                cell.accessoryType = .checkmark
                cell.tintColor = #colorLiteral(red: 0.5725490451, green: 0, blue: 0.2313725501, alpha: 1)
            }*/
        }
    }
}
