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
    
    /*
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
    */
    public var amount: Double {
    
        let tab:  [ExpenseTraveller] = self.pexpensetraveller?.allObjects as! [ExpenseTraveller]
    
        var result = 0.0
    
        for t in tab {
            result = result + t.pamountCreator
        }
    
        return result
    
    }
    
    
    convenience init(name: String, image: Data, date: Date, travellers: [Traveller], amountCreator: [Double], amountDept: [Double]) {
        self.init(context: CoreDataManager.context)
        self.pname = name
        self.pimage = image
        self.pdate = date
        
        
        for i in 0 ..< travellers.count{
            let tmp: ExpenseTraveller = ExpenseTraveller(context: CoreDataManager.context)
            
            tmp.pamountCreator = amountCreator[i]
            tmp.pamoutDebt = amountDept[i]
            tmp.ptraveller = travellers[i]
            
            travellers[i].addToPexpensetraveller(tmp)
            self.addToPexpensetraveller(tmp)
        }
    }
}
