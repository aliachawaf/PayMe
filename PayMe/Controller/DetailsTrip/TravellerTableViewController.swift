//
//  TravellerTableViewController.swift
//  PayMe
//
//  Created by Alia Chawaf on 29/03/2019.
//  Copyright © 2019 Chawaf Alia & Gestin Rémi. All rights reserved.
//

import UIKit
import CoreData

class TravellerTableViewController: NSObject, UITableViewDataSource, TravellerViewModelDelegate, UITableViewDelegate {
    
    var travellerTV: UITableView!
    var trip: Trip
    var travellerViewModel: TravellerViewModel
    var viewController: DetailsTripController?
    let fetchResultController : TravellerFetchResultsController
    
    init(tv: UITableView!, trip: Trip) {
        
        self.travellerTV = tv
        self.trip = trip
        self.fetchResultController = TravellerFetchResultsController(view: self.travellerTV, trip: self.trip)
        self.travellerViewModel = TravellerViewModel(data: self.fetchResultController.travellersFetched)
        
        super.init()
        self.travellerTV.dataSource = self
        self.travellerTV.delegate = self
        self.travellerViewModel.delegate = self
    }
    
    //-------------------------------------------------------------------------------------------------
    // MARK: - TravellerViewModelDelegate
    
    /// called when set globally changes
    func dataSetChanged() {
        self.travellerTV.reloadData()
    }
    
    /// called when a Traveller is deleted from set
    ///
    /// - Parameter indexPath: (section,row) of deletion
    func travellerDeleted(at indexPath: IndexPath) {
        self.travellerTV.selectRow(at: indexPath, animated: true, scrollPosition: UITableView.ScrollPosition.middle)
    }
    
    /// called when a Traveller is updated in set
    ///
    /// - Parameter indexPath: (section, row) of updating
    func travellerUpdated(at indexPath: IndexPath) {
        self.travellerTV.selectRow(at: indexPath, animated: true, scrollPosition: UITableView.ScrollPosition.middle)
    }
    
    /// called when a Traveller is added to set
    ///
    /// - Parameter indexPath: (section,row) of add
    func travellerAdded(at indexPath: IndexPath) {
        self.travellerTV.selectRow(at: indexPath, animated: true, scrollPosition: UITableView.ScrollPosition.middle)
    }
    
    
    //-------------------------------------------------------------------------------------------------
    // MARK: - TableViewDataSource
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return travellerViewModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Fetch a cell of the appropriate type.
        let cell = travellerTV.dequeueReusableCell(withIdentifier: "cellTypeIdentifier", for: indexPath) as! TravellerTripCell
        
        // Configure the cell’s contents
        cell.textLabel!.text = (self.travellerViewModel.get(travellerAt: indexPath.row)?.fullname())!

        let balance = self.travellerViewModel.get(travellerAt: indexPath.row)!.balance
        
        cell.balance.text = String(balance) + " €" 
        
        if balance < 0 {
            cell.balance.backgroundColor = #colorLiteral(red: 1, green: 0.4033368393, blue: 0.4369280409, alpha: 1)
        } else {
            cell.balance.backgroundColor = #colorLiteral(red: 0.6474267826, green: 1, blue: 0.6095485427, alpha: 1)
        }
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
 
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        let n = travellerViewModel.count
        
        if  n > 1 {
            return String(n) + " Voyageurs"
        } else {
            return String(n) + " Voyageur"
        }
    }
    
    //-------------------------------------------------------------------------------------------------
    // MARK: - UITableViewDelegate

    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        
        let edit = UITableViewRowAction(style: .normal, title: "Modifier") { action, index in
            
            self.viewController!.travellerToEdit = self.travellerViewModel.get(travellerAt: index.row)
            
            self.viewController!.performSegue(withIdentifier: "editTraveller", sender: nil)
            
        }
        edit.backgroundColor = #colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1)
        
        let delete = UITableViewRowAction(style: .destructive, title: "Supprimer") { action, index in
            self.travellerViewModel.delete(tripAt: indexPath)
        }
        delete.backgroundColor = #colorLiteral(red: 1, green: 0.1982439173, blue: 0.2032906869, alpha: 1)
        
        return [delete, edit]
    }
}
