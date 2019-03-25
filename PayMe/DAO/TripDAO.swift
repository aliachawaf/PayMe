//
//  TripDAO.swift
//  PayMe
//
//  Created by Alia Chawaf on 25/03/2019.
//  Copyright © 2019 Chawaf Alia & Gestin Rémi. All rights reserved.
//

import UIKit
import CoreData

class TripDAO {

    static let request : NSFetchRequest<Trip> = Trip.fetchRequest()
    
    static func save(){
        CoreDataManager.save()
    }
    
    static func delete(trip: Trip){
        CoreDataManager.context.delete(trip)
    }
    
    static func fetchAll() -> [Trip]?{
        self.request.predicate = nil
        do{
            return try CoreDataManager.context.fetch(self.request)
        }
        catch{
            return nil
        }
    }
    
    // number of trips
    static var count: Int{
        self.request.predicate = nil
        do{
            return try CoreDataManager.context.count(for: self.request)
        }
        catch let error as NSError{
            fatalError(error.description)
        }
    }
}
