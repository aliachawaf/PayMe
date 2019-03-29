//
//  TravellerTableViewController.swift
//  PayMe
//
//  Created by Alia Chawaf on 29/03/2019.
//  Copyright © 2019 Chawaf Alia & Gestin Rémi. All rights reserved.
//

import UIKit
import CoreData

class TravellerTableViewController: NSObject, UITableViewDataSource, TravellerViewModelDelegate {
    
    var travellerTV: UITableView!
    var trip: Trip
    var travellerViewModel: TravellerViewModel
    let fetchResultController : TravellerFetchResultsController
    
    init(tv: UITableView!, trip: Trip) {
        
        self.travellerTV = tv
        self.trip = trip
        self.fetchResultController = TravellerFetchResultsController(view: self.travellerTV, trip: self.trip)
        self.travellerViewModel = TravellerViewModel(data: self.fetchResultController.travellersFetched)
        
        super.init()
        self.travellerTV.dataSource = self
        self.travellerViewModel.delegate = self
        
    }
    
    func dataSetChanged() {
        print("reload")
        self.travellerTV.reloadData()
    }
    
    func travellerDeleted(at indexPath: IndexPath) {
        self.travellerTV.selectRow(at: indexPath, animated: true, scrollPosition: UITableView.ScrollPosition.middle)
    }
    
    func travellerUpdated(at indexPath: IndexPath) {
        self.travellerTV.selectRow(at: indexPath, animated: true, scrollPosition: UITableView.ScrollPosition.middle)
    }
    
    func travellerAdded(at indexPath: IndexPath) {
        self.travellerTV.selectRow(at: indexPath, animated: true, scrollPosition: UITableView.ScrollPosition.middle)
    }
    
    
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
        
        return cell
    }
    
    
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            self.travellerViewModel.delete(tripAt: indexPath)
        }
    }
    
    

}
