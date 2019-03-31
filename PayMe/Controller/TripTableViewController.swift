//
//  TripTableViewController.swift
//  PayMe
//
//  Created by Alia Chawaf on 25/03/2019.
//  Copyright © 2019 Chawaf Alia & Gestin Rémi. All rights reserved.
//

import UIKit
import CoreData

class TripTableViewController: NSObject, UITableViewDataSource, TripViewModelDelegate, UITableViewDelegate {
    
    var tripTV: UITableView!
    var tripViewModel: TripViewModel
    let fetchResultController : TripFetchResultsController
    var viewTripList : ViewController?
    
    init(tv: UITableView!) {
        
        self.tripTV = tv
        self.fetchResultController = TripFetchResultsController(view: tripTV)
        self.tripViewModel = TripViewModel(data: self.fetchResultController.tripsFetchedNotFinished)
        
        super.init()
        self.tripTV.dataSource = self
        self.tripTV.delegate = self
        self.tripViewModel.delegate = self
    }
    
    //-------------------------------------------------------------------------------------------------
    // MARK: - TripViewModelDelegate
    
    /// called when set globally changes
    func dataSetChanged() {
        self.tripTV.reloadData()
    }
    
    /// called when a Trip is deleted from set
    ///
    /// - Parameter indexPath: (section,row) of deletion
    func tripDeleted(at indexPath: IndexPath) {
        self.tripTV.selectRow(at: indexPath, animated: true, scrollPosition: UITableView.ScrollPosition.middle)
    }
    
    /// called when a Trip is updated in set
    ///
    /// - Parameter indexPath: (section, row) of updating
    func tripUpdated(at indexPath: IndexPath) {
        self.tripTV.selectRow(at: indexPath, animated: true, scrollPosition: UITableView.ScrollPosition.middle)
    }
    
    /// called when a Trip is added to set
    ///
    /// - Parameter indexPath: (section,row) of add
    func tripAdded(at indexPath: IndexPath) {
        self.tripTV.selectRow(at: indexPath, animated: true, scrollPosition: UITableView.ScrollPosition.middle)
    }
    
    
    //-------------------------------------------------------------------------------------------------
    // MARK: - TableView DataSource
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tripViewModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Fetch a cell of the appropriate type.
        let cell = tripTV.dequeueReusableCell(withIdentifier: "cellTypeIdentifier", for: indexPath)
        
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
    
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let edit = UITableViewRowAction(style: .normal, title: "Modifier") { action, index in
            self.viewTripList!.tripToEdit = self.tripViewModel.get(tripAt: index.row)
            self.viewTripList!.performSegue(withIdentifier: "editTrip", sender: nil)
            
        }
        edit.backgroundColor = #colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1)
        
        let delete = UITableViewRowAction(style: .normal, title: "Supprimer") { action, index in
            self.tripViewModel.delete(tripAt: indexPath)
        }
        delete.backgroundColor = #colorLiteral(red: 1, green: 0.1982439173, blue: 0.2032906869, alpha: 1)
        
        return [delete, edit]
    }
}
