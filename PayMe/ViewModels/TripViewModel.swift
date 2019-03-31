//
//  TripViewModel.swift
//  PayMe
//
//  Created by Alia Chawaf on 25/03/2019.
//  Copyright © 2019 Chawaf Alia & Gestin Rémi. All rights reserved.
//

import UIKit
import CoreData

protocol TripViewModelDelegate {
    // MARK: -
    /// called when set globally changes
    func dataSetChanged()
    /// called when a trip is deleted from set
    ///
    /// - Parameter indexPath: (section,row) of deletion
    func tripDeleted(at indexPath: IndexPath)
    /// called when a trip is updated in set
    ///
    /// - Parameter indexPath: (section, row) of updating
    func tripUpdated(at indexPath: IndexPath)
    /// called when a trip is added to set
    ///
    /// - Parameter indexPath: (section,row) of add
    func tripAdded(at indexPath: IndexPath)
}

class TripViewModel {
    
    var delegate : TripViewModelDelegate? = nil
    var tripsFetched: NSFetchedResultsController<Trip>
    
    init(data: NSFetchedResultsController<Trip>) {
        self.tripsFetched = data
    }
    
    
    public var count: Int{
        return self.tripsFetched.fetchedObjects?.count ?? 0
    }
    
    func get(tripAt index: Int) -> Trip? {
        return self.tripsFetched.object(at: IndexPath(row: index, section: 0))
    }
    
    
    public func add(trip: Trip){
        
        if let indexPath = self.tripsFetched.indexPath(forObject: trip){
            self.delegate?.tripAdded(at: indexPath)
        }
    }
    
    public func delete(tripAt indexPath: IndexPath){
        
            CoreDataManager.context.delete(tripsFetched.object(at: indexPath))
            self.delegate?.tripDeleted(at: indexPath)
    }
    
    
}

