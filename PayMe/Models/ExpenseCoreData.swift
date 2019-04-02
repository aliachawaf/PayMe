//
//  ExpenseCoreData.swift
//  PayMe
//
//  Created by Alia Chawaf on 01/04/2019.
//  Copyright © 2019 Chawaf Alia & Gestin Rémi. All rights reserved.
//

import UIKit

extension Expense {
    
    public var image: Data? {return self.pimage}
    public var name: String {return self.pname ?? ""}
    public var date: Date? {return self.pdate}
    
    public var travellerCreator: Traveller {
        
        let tab:  [ExpenseTraveller] = self.pexpensetraveller?.allObjects as! [ExpenseTraveller]
        
        var result: Traveller?
        
        for t in tab {
            if (t.pcreator) {
                result = t.ptraveller!
            }
        }
        
        return result!
        
    }
    
    public var travellersConcerned: [Traveller]  {
        
        let tab:  [ExpenseTraveller] = self.pexpensetraveller?.allObjects as! [ExpenseTraveller]
        
        var results: [Traveller] = []
        
        for t in tab {
            if (!t.pcreator) {
                results.append(t.ptraveller!)
            }
        }
        
        return results
    }
    
    public var amount: Double {
    
        let tab:  [ExpenseTraveller] = self.pexpensetraveller?.allObjects as! [ExpenseTraveller]
    
        var result: Double?
    
        for t in tab {
            if (t.pcreator) {
                result = t.pamount
            }
        }
    
        return result!
    
    }
    
    convenience init(name: String, image: Data, date: Date, amount: Double, travellerCreator: Traveller, travellersConcerned: [Traveller]) {
        self.init(context: CoreDataManager.context)
        self.pname = name
        self.pimage = image
        self.pdate = date
        
        for t in travellersConcerned {
            let tmp: ExpenseTraveller = ExpenseTraveller(context: CoreDataManager.context)
            
            tmp.pamount = amount / Double(travellersConcerned.count)
            tmp.ptraveller = t
            tmp.pcreator = false
            
            t.addToPexpensetraveller(tmp)
            self.addToPexpensetraveller(tmp)
        }
        
        let tmpCreator: ExpenseTraveller = ExpenseTraveller(context: CoreDataManager.context)
        
        tmpCreator.pamount = amount
        tmpCreator.ptraveller = travellerCreator
        tmpCreator.pcreator = true
        
        travellerCreator.addToPexpensetraveller(tmpCreator)
        self.addToPexpensetraveller(tmpCreator)
        
    }
}
