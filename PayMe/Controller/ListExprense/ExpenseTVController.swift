//
//  ExpenseTVController.swift
//  PayMe
//
//  Created by Alia Chawaf on 03/04/2019.
//  Copyright © 2019 Chawaf Alia & Gestin Rémi. All rights reserved.
//

import UIKit

class ExpenseTVController: NSObject, UITableViewDataSource, ExpenseViewModelDelegate, UITableViewDelegate {
    

    var expenseTV: UITableView!
    var expenseViewModel: ExpenseViewModel
    let fetchResultController : ExpenseFetchResultsController
    var viewController : ListExpenseViewController?
    var trip: Trip

    init(tv: UITableView!, trip: Trip) {
        
        self.trip = trip
        self.expenseTV = tv
        self.fetchResultController = ExpenseFetchResultsController(view: expenseTV, trip: self.trip)
        self.expenseViewModel = ExpenseViewModel(data: self.fetchResultController.expensesFetched)
        
        super.init()
        self.expenseTV.dataSource = self
        self.expenseTV.delegate = self
        self.expenseViewModel.delegate = self
    }

    
    //-------------------------------------------------------------------------------------------------
    // MARK: - expenseViewModelDelegate
    
    /// called when set globally changes
    func dataSetChanged() {
        self.expenseTV.reloadData()
    }
    
    /// called when a expense is deleted from set
    ///
    /// - Parameter indexPath: (section,row) of deletion
    func expenseDeleted(at indexPath: IndexPath) {
        self.expenseTV.selectRow(at: indexPath, animated: true, scrollPosition: UITableView.ScrollPosition.middle)
    }
    
    /// called when a expense is updated in set
    ///
    /// - Parameter indexPath: (section, row) of updating
    func expenseUpdated(at indexPath: IndexPath) {
        self.expenseTV.selectRow(at: indexPath, animated: true, scrollPosition: UITableView.ScrollPosition.middle)
    }
    
    /// called when a expense is added to set
    ///
    /// - Parameter indexPath: (section,row) of add
    func expenseAdded(at indexPath: IndexPath) {
        self.expenseTV.selectRow(at: indexPath, animated: true, scrollPosition: UITableView.ScrollPosition.middle)
    }
    
    
    //-------------------------------------------------------------------------------------------------
    // MARK: - TableViewDataSource
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return expenseViewModel.count
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Fetch a cell of the appropriate type.
        let cell = expenseTV.dequeueReusableCell(withIdentifier: "cellTypeIdentifier", for: indexPath)
        
        // Configure the cell’s contents
        cell.textLabel!.text = self.expenseViewModel.get(expenseAt: indexPath.row)?.name
        
        return cell
    }
    
    //-------------------------------------------------------------------------------------------------
    // MARK: - UITableViewDelegate
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
      /*  let edit = UITableViewRowAction(style: .normal, title: "Modifier") { action, index in
            self.viewController!.expenseToEdit = self.tripViewModel.get(tripAt: index.row)
            self.viewController!.performSegue(withIdentifier: "editExpense", sender: nil)
            
        }
        edit.backgroundColor = #colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1)
        */
        let delete = UITableViewRowAction(style: .destructive, title: "Supprimer") { action, index in
            self.expenseViewModel.delete(expenseAt: index)
        }
        delete.backgroundColor = #colorLiteral(red: 1, green: 0.1982439173, blue: 0.2032906869, alpha: 1)
        
        //return [delete, edit]
        return [delete]
    }
    
}
