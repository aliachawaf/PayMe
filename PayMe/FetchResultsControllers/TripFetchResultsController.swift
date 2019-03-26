//
//  TripFetchResultsController.swift
//  PayMe
//
//  Created by Alia Chawaf on 25/03/2019.
//  Copyright © 2019 Chawaf Alia & Gestin Rémi. All rights reserved.
//

import UIKit
import CoreData

class TripFetchResultsController: NSObject, NSFetchedResultsControllerDelegate {
    
    let tableView: UITableView
    
    
    init(view: UITableView) {
        self.tableView = view
        super.init()
        do {
            try self.tripsFetchedNotFinished.performFetch()
            try self.tripsFetchedFinished.performFetch()
           
        }
        catch let error as NSError {
            fatalError(error.description)
        }
    }
    // var monNSFetchResCtrl: NSFetchedResultsController?
    lazy var tripsFetchedNotFinished: NSFetchedResultsController<Trip> = {
        let request: NSFetchRequest<Trip> = Trip.fetchRequest()
        request.predicate = NSPredicate(format: "pfinished == %@", NSNumber(value: false))
        request.sortDescriptors =
            [NSSortDescriptor(key:#keyPath(Trip.pname), ascending: true)]
        let fetchResultController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: CoreDataManager.context, sectionNameKeyPath: nil, cacheName: nil)
        fetchResultController.delegate = self
        return fetchResultController
    }()
    
    lazy var tripsFetchedFinished: NSFetchedResultsController<Trip> = {
        let request: NSFetchRequest<Trip> = Trip.fetchRequest()
        request.predicate = NSPredicate(format: "pfinished == %@", NSNumber(value: true))
        request.sortDescriptors =
            [NSSortDescriptor(key:#keyPath(Trip.pname), ascending: true)]
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
            print("jeff le best")
            if let newIndexPath = newIndexPath{
                self.tableView.insertRows(at: [newIndexPath], with: .automatic)
            }
            
        case .delete:
            print("damien")
            if let indexPath = indexPath {
                self.tableView.deleteRows(at: [indexPath], with: .automatic)
            }
            
        case .update:
            print("alia hhhhhh")
            if let indexPath = indexPath {
                self.tableView.reloadRows(at: [indexPath], with: .automatic)
            }
        default:
            break
        }
    }
}
