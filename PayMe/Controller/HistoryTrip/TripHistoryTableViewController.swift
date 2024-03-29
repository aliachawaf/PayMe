//
//  TripTableViewController.swift
//  PayMe
//
//  Created by Alia Chawaf on 25/03/2019.
//  Copyright © 2019 Chawaf Alia & Gestin Rémi. All rights reserved.
//

import UIKit
import CoreData

class TripHistoryTableViewController: NSObject, UITableViewDataSource, TripViewModelDelegate {
    
    var tripTV: UITableView!
    var tripViewModel: TripViewModel
    let fetchResultController : TripHistoryFetchResultsController
    
    init(tv: UITableView!) {
        
        self.tripTV = tv
        self.fetchResultController = TripHistoryFetchResultsController(view: tripTV)
        self.tripViewModel = TripViewModel(data: self.fetchResultController.tripsHistoryFetched)
        
        super.init()
        self.tripTV.dataSource = self
        self.tripViewModel.delegate = self
    }
    
    //-------------------------------------------------------------------------------------------------
    // MARK: - TripViewModelDelegate
    
    /// called when set globally changes
    func dataSetChanged() {
        self.tripTV.reloadData()
    }
    
    /// called when a Trip is deleted from set history
    ///
    /// - Parameter indexPath: (section,row) of deletion
    func tripDeleted(at indexPath: IndexPath) {
        self.tripTV.selectRow(at: indexPath, animated: true, scrollPosition: UITableView.ScrollPosition.middle)
    }
    
    /// called when a Trip of the history is updated in set
    ///
    /// - Parameter indexPath: (section, row) of updating
    func tripUpdated(at indexPath: IndexPath) {
        self.tripTV.selectRow(at: indexPath, animated: true, scrollPosition: UITableView.ScrollPosition.middle)
    }
    
    
    /// called when a Trip is added to set of history
    ///
    /// - Parameter indexPath: (section,row) of add
    func tripAdded(at indexPath: IndexPath) {
        self.tripTV.selectRow(at: indexPath, animated: true, scrollPosition: UITableView.ScrollPosition.middle)
    }
    
    
    //-------------------------------------------------------------------------------------------------
    // MARK: - TableViewDataSource
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tripViewModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Fetch a cell of the appropriate type.
        let cell = tripTV.dequeueReusableCell(withIdentifier: "cellHistory", for: indexPath)
        
        // Configure the cell’s contents
        cell.textLabel!.text = self.tripViewModel.get(tripAt: indexPath.row)?.name
        
        if let dataImage = self.tripViewModel.get(tripAt: indexPath.row)?.image {
            
            cell.imageView?.image = UIImage(data: dataImage)
        } else {
            cell.imageView?.image = #imageLiteral(resourceName: "addimage")
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            self.tripViewModel.delete(tripAt: indexPath)
        }
    }
}
