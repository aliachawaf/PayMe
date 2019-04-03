//
//  ExpenseFetchResultsController.swift
//  PayMe
//
//  Created by Alia Chawaf on 03/04/2019.
//  Copyright © 2019 Chawaf Alia & Gestin Rémi. All rights reserved.
//

import UIKit
import CoreData

class ExpenseFetchResultsController: NSObject, NSFetchedResultsControllerDelegate {

    var tableView: UITableView!
    var trip: Trip
    
    init(view: UITableView, trip: Trip) {
        self.tableView = view
        self.trip = trip
        super.init()
        do {
            try self.expensesFetched.performFetch()
            
        }
        catch let error as NSError {
            fatalError(error.description)
        }
    }
    
    
    //-------------------------------------------------------------------------------------------------
    // MARK: - FetchResultController
    
    lazy var expensesFetched: NSFetchedResultsController<Expense> = {
        let request: NSFetchRequest<Expense> = Expense.fetchRequest()
       
        request.predicate = NSPredicate(format: "ANY pexpensetraveller.ptraveller.ptrip == %@", self.trip)
        
        request.sortDescriptors =
            [NSSortDescriptor(key:#keyPath(Expense.pname), ascending: true)]
        let fetchResultController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: CoreDataManager.context, sectionNameKeyPath: nil, cacheName: nil)
        fetchResultController.delegate = self
        return fetchResultController
    }()
    
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        self.tableView.beginUpdates()
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        self.tableView.endUpdates()
        CoreDataManager.save()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case .insert:
            
            if let newIndexPath = newIndexPath{
                self.tableView.insertRows(at: [newIndexPath], with: .automatic)
            }
            
        case .delete:
            
            if let indexPath = indexPath {
                self.tableView.deleteRows(at: [indexPath], with: .automatic)
            }
            
        case .update:
            
            if let indexPath = indexPath {
                self.tableView.reloadRows(at: [indexPath], with: .automatic)
            }
        default:
            break
        }
    }
    
}
