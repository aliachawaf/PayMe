//
//  TravellerViewModel.swift
//  PayMe
//
//  Created by Alia Chawaf on 29/03/2019.
//  Copyright © 2019 Chawaf Alia & Gestin Rémi. All rights reserved.
//

import UIKit

import CoreData

protocol TravellerViewModelDelegate {
    // MARK: -
    /// called when set globally changes
    func dataSetChanged()
    /// called when a trip is deleted from set
    ///
    /// - Parameter indexPath: (section,row) of deletion
    func travellerDeleted(at indexPath: IndexPath)
    /// called when a trip is updated in set
    ///
    /// - Parameter indexPath: (section, row) of updating
    func travellerUpdated(at indexPath: IndexPath)
    /// called when a trip is added to set
    ///
    /// - Parameter indexPath: (section,row) of add
    func travellerAdded(at indexPath: IndexPath)
}

class TravellerViewModel {

    var delegate : TravellerViewModelDelegate? = nil
    var travellersFetched: NSFetchedResultsController<Traveller>
    
    init(data: NSFetchedResultsController<Traveller>) {
        self.travellersFetched = data
    }
    
    
    public var count: Int{
        return self.travellersFetched.fetchedObjects?.count ?? 0
    }
    
    func get(travellerAt index: Int) -> Traveller? {
        return self.travellersFetched.object(at: IndexPath(row: index, section: 0))
    }
    
    
    public func add(traveller: Traveller){
        
        if let indexPath = self.travellersFetched.indexPath(forObject: traveller){
            self.delegate?.travellerAdded(at: indexPath)
        }
    }
    
    public func delete(tripAt indexPath: IndexPath){
        
        CoreDataManager.context.delete(travellersFetched.object(at: indexPath))
        self.delegate?.travellerDeleted(at: indexPath)
        
    }
}
