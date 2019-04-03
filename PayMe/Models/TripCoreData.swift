//
//  TripCoreData.swift
//  PayMe
//
//  Created by Alia Chawaf on 25/03/2019.
//  Copyright © 2019 Chawaf Alia & Gestin Rémi. All rights reserved.
//

import Foundation

// MARK: -
/**
 Trip type
 
 **name**: Trip -> String
 **finished**: Trip -> Bool
 **image**: Trip -> Data
 */

extension Trip {
    
    // MARK: -
    
    /// name of Trip
    public var name: String { return self.pname ?? "" }
    /// finished state or not of Trip
    public var finished: Bool { return self.pfinished}
    /// image of Trip
    public var image: Data? {return self.pimage}
    
    public var totalAmount: Double? {
        let tabTraveller:  [Traveller] = self.ptravellers?.allObjects as! [Traveller]
    
        var result = 0.0
        
        for t in tabTraveller {
            let expenseTab: [ExpenseTraveller] = t.pexpensetraveller!.allObjects as! [ExpenseTraveller]
            for e in expenseTab {
                if !e.pexpense!.isRefund {
                result = result + e.pamountCreator
                }
            }
        }
        
        return result
        
    }
    
    
    /// initialiez a 'Trip'
    ///
    /// - Parameters:
    ///   - name: 'String' name of Trip
    ///   - finished: 'Bool' finished or not of Trip
    convenience init(name: String, finished: Bool) {
        self.init(context: CoreDataManager.context)
        self.pname = name
        self.pfinished = finished
        self.pimage = nil
    }
    
    /// initialiez a 'Trip'
    ///
    /// - Parameters:
    ///   - name: 'String' name of Trip
    ///   - finished: 'Bool' finished or not of Trip
    ///   - image: 'Data' image of Trip
    convenience init(name: String, finished: Bool, image: Data) {
        self.init(context: CoreDataManager.context)
        self.pname = name
        self.pfinished = finished
        self.pimage = image
    }
    
    
    /// Change the finished state of Trip
    func changeFinished(){
        self.pfinished = !self.pfinished
    }
    
    /// Return the finished state of Trip
    func isFinished() -> Bool {
        return self.pfinished
    }
    
    
    
    /// Update infos of the Trip
    ///
    /// - Parameters:
    ///   - newName: String of the new name of the Trip
    ///   - newImage: Data of the new image of the Trip
    func updateTripInfos(newName: String, newImage: Data) {
        self.pname = newName
        self.pimage = newImage
    }
}
