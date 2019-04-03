//
//  ExpenseViewModel.swift
//  PayMe
//
//  Created by Alia Chawaf on 03/04/2019.
//  Copyright © 2019 Chawaf Alia & Gestin Rémi. All rights reserved.
//

import UIKit
import CoreData

protocol ExpenseViewModelDelegate {
    // MARK: -
    /// called when set globally changes
    func dataSetChanged()
    /// called when a expense is deleted from set
    ///
    /// - Parameter indexPath: (section,row) of deletion
    func expenseDeleted(at indexPath: IndexPath)
    /// called when a expense is updated in set
    ///
    /// - Parameter indexPath: (section, row) of updating
    func expenseUpdated(at indexPath: IndexPath)
    /// called when a expense is added to set
    ///
    /// - Parameter indexPath: (section,row) of add
    func expenseAdded(at indexPath: IndexPath)
}

class ExpenseViewModel {

    var delegate : ExpenseViewModelDelegate? = nil
    var expensesFetched: NSFetchedResultsController<Expense>
    
    init(data: NSFetchedResultsController<Expense>) {
        self.expensesFetched = data
    }
    
    
    public var count: Int{
        return self.expensesFetched.fetchedObjects?.count ?? 0
    }
    
    func get(expenseAt index: Int) -> Expense? {
        return self.expensesFetched.object(at: IndexPath(row: index, section: 0))
    }
    
    func getAll() -> [Expense]? {
        
        return self.expensesFetched.fetchedObjects
        
    }
    
    
    public func add(expense: Expense){
        
        if let indexPath = self.expensesFetched.indexPath(forObject: expense){
            self.delegate?.expenseAdded(at: indexPath)
        }
    }
    
    public func delete(expenseAt indexPath: IndexPath){
        
        CoreDataManager.context.delete(expensesFetched.object(at: indexPath))
        self.delegate?.expenseDeleted(at: indexPath)
        
    }
}
