//
//  TripCoreData.swift
//  PayMe
//
//  Created by Alia Chawaf on 25/03/2019.
//  Copyright © 2019 Chawaf Alia & Gestin Rémi. All rights reserved.
//

import Foundation

extension Trip {
    
    public var name:String { return self.pname ?? "" }
    
    convenience init(name: String) {
        self.init(context: CoreDataManager.context)
        self.pname = name
    }
}
