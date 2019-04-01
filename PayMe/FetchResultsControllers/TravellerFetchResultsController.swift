//
//  TravellerFetchResultsController.swift
//  PayMe
//
//  Created by Alia Chawaf on 29/03/2019.
//  Copyright © 2019 Chawaf Alia & Gestin Rémi. All rights reserved.
//

import UIKit
import CoreData

class TravellerFetchResultsController: NSObject, NSFetchedResultsControllerDelegate {
    
    var tableView: UITableView!
    var trip: Trip
    
    init(view: UITableView, trip: Trip) {
        self.tableView = view
        self.trip = trip
        super.init()
        do {
            try self.travellersFetched.performFetch()
            
        }
        catch let error as NSError {
            fatalError(error.description)
        }
    }
    
    init (trip: Trip) {
        self.trip = trip
        super.init()
        do {
            try self.travellersFetched.performFetch()
        }
        catch let error as NSError {
            fatalError(error.description)
        }
    }
    
    //-------------------------------------------------------------------------------------------------
    // MARK: - FetchResultController
    
    lazy var travellersFetched: NSFetchedResultsController<Traveller> = {
        let request: NSFetchRequest<Traveller> = Traveller.fetchRequest()
        request.predicate = NSPredicate(format: "ptrip == %@", self.trip)
        request.sortDescriptors =
            [NSSortDescriptor(key:#keyPath(Traveller.pfirstname), ascending: true)]
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
            print("add traveller")
            if let newIndexPath = newIndexPath{
                self.tableView.insertRows(at: [newIndexPath], with: .automatic)
            }
            
        case .delete:
            print("damien")
            if let indexPath = indexPath {
                self.tableView.deleteRows(at: [indexPath], with: .automatic)
            }
            
        case .update:
            print("update traveller")
            if let indexPath = indexPath {
                self.tableView.reloadRows(at: [indexPath], with: .automatic)
            }
        default:
            break
        }
    }
}
