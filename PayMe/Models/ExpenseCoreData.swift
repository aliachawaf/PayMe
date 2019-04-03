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
    
 
    
    public var travellers: [Traveller] {
        
        var tabResult: [Traveller] = []
        let tabET:  [ExpenseTraveller] = self.pexpensetraveller?.allObjects as! [ExpenseTraveller]
        
        for e in tabET {
            
                tabResult.append(e.ptraveller!)
            
        }
        
        return tabResult
        
    }
    
    public var amountCreator: [Double] {
        var tabResult: [Double] = []
        let tabET:  [ExpenseTraveller] = self.pexpensetraveller?.allObjects as! [ExpenseTraveller]
        
        for e in tabET {
            
            tabResult.append(e.pamountCreator)
            
        }
        
        return tabResult
    }
    
    public var amountDebt: [Double] {
        var tabResult: [Double] = []
        let tabET:  [ExpenseTraveller] = self.pexpensetraveller?.allObjects as! [ExpenseTraveller]
        
        for e in tabET {
            
            tabResult.append(e.pamoutDebt)
            
        }
        
        return tabResult
    }
    
    public var trip: Trip? {
        
        let tab:  [ExpenseTraveller] = self.pexpensetraveller?.allObjects as! [ExpenseTraveller]        
        return tab[0].ptraveller?.ptrip
    }
    

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
    
    convenience init(refund: Refund ) {
        self.init(context: CoreDataManager.context)
        self.pname = "Remboursement de " + refund.travellerInDebt.fullname() + " vers " + refund.travellerToRefund.fullname()
        self.pimage = UIImage(named: "refund")?.jpegData(compressionQuality: 1)
        self.pdate = Date()
        
        print(self.pdate)
        
        for i in 0 ..< travellers.count{
            let tmp: ExpenseTraveller = ExpenseTraveller(context: CoreDataManager.context)
            
            tmp.pamountCreator = amountCreator[i]
            tmp.pamoutDebt = amountDebt[i]
            tmp.ptraveller = travellers[i]
            
            travellers[i].addToPexpensetraveller(tmp)
            self.addToPexpensetraveller(tmp)
        }
    }
}
