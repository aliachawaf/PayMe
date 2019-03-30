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
}
