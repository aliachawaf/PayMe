//
//  TripTableViewController.swift
//  PayMe
//
//  Created by Alia Chawaf on 25/03/2019.
//  Copyright © 2019 Chawaf Alia & Gestin Rémi. All rights reserved.
//

import UIKit

class TripTableViewController: NSObject, UITableViewDataSource, TripViewModelDelegate {
    
    var tripTV: UITableView!
    
    var tripViewModel: TripViewModel
    let fetchResultController : TripFetchResultsController
    
    init(tv: UITableView!) {
        
        self.tripTV = tv
        self.fetchResultController = TripFetchResultsController(view: tripTV)
        self.tripViewModel = TripViewModel(data: self.fetchResultController.tripsFetched)
        
        super.init()
        self.tripTV.dataSource = self
        self.tripViewModel.delegate = self
        
    }
    
    func dataSetChanged() {
        self.tripTV.reloadData()
    }
    
    func tripDeleted(at indexPath: IndexPath) {
        self.tripTV.selectRow(at: indexPath, animated: true, scrollPosition: UITableView.ScrollPosition.middle)
    }
    
    func tripUpdated(at indexPath: IndexPath) {
        self.tripTV.selectRow(at: indexPath, animated: true, scrollPosition: UITableView.ScrollPosition.middle)
    }
    
    func tripAdded(at indexPath: IndexPath) {
        self.tripTV.selectRow(at: indexPath, animated: true, scrollPosition: UITableView.ScrollPosition.middle)
    }
    
    
    
    
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tripViewModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        print("table view")
        print(tripViewModel.count)
        
        // Fetch a cell of the appropriate type.
        let cell = tripTV.dequeueReusableCell(withIdentifier: "cellTypeIdentifier", for: indexPath)
        
        // Configure the cell’s contents
        
        cell.textLabel!.text = self.tripViewModel.get(personAt: indexPath.row)?.name
        
        return cell
    }

}
