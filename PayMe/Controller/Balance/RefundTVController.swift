//
//  RefundTVController.swift
//  PayMe
//
//  Created by Alia Chawaf on 03/04/2019.
//  Copyright © 2019 Chawaf Alia & Gestin Rémi. All rights reserved.
//

import UIKit

class RefundTVController: NSObject, UITableViewDataSource, UITableViewDelegate {
    
    var travellerTV: UITableView!
    var trip: Trip
    var travellerViewModel: TravellerViewModel
    let fetchResultController : TravellerFetchResultsController
    
    
    init(tv: UITableView!, trip: Trip) {
        
        self.travellerTV = tv
        self.trip = trip
        self.fetchResultController = TravellerFetchResultsController(view: self.travellerTV, trip: self.trip)
        self.travellerViewModel = TravellerViewModel(data: self.fetchResultController.travellersFetched)
        
        super.init()
        self.travellerTV.dataSource = self
        self.travellerTV.delegate = self
    }
    
    func getRefunds() -> [Refund] {
        
        var results: [Refund] = []
        
        let travellers = self.travellerViewModel.getAll()!
        
        var travellersPositif = travellers.filter { $0.balance > 0.0 }
        var travellersNegatif = travellers.filter { $0.balance <= 0.0 }
        
        travellersPositif.sort(by: {$0.balance > $1.balance})
        travellersNegatif.sort(by: {$0.balance < $1.balance})
        
        if travellersPositif.count > 0 {
       
        var cptP = 0
        var cptN = 0
        var balancetmpP = travellersPositif[0].balance
        var balancetmpN = -travellersNegatif[0].balance
        
        while (cptP < travellersPositif.count && cptN < travellersNegatif.count) {
            
            
            
            if (balancetmpP > balancetmpN) {
                results.append(Refund(amount: balancetmpN, travellerToRefund: travellersPositif[cptP], travellerInDebt: travellersNegatif[cptN] ))
                
                balancetmpP = balancetmpP - balancetmpN
                cptN = cptN + 1
                if (cptN < travellersNegatif.count) {
                    balancetmpN = -travellersNegatif[cptN].balance
                }
                
            } else if (balancetmpP < balancetmpN) {
                results.append(Refund(amount: balancetmpP, travellerToRefund: travellersPositif[cptP], travellerInDebt: travellersNegatif[cptN] ))
                
                balancetmpN = balancetmpN - balancetmpP
                cptP = cptP + 1
                if (cptP < travellersPositif.count) {
                    balancetmpP = travellersPositif[cptP].balance
                }
                
            } else if (balancetmpN == balancetmpP)  {
               results.append(Refund(amount: balancetmpP, travellerToRefund: travellersPositif[cptP], travellerInDebt: travellersNegatif[cptN] ))
                
                cptN = cptN + 1
                cptP = cptP + 1
                if (cptP < travellersPositif.count) {
                    balancetmpP = travellersPositif[cptP].balance
                }
                if (cptN < travellersNegatif.count) {
                    balancetmpN = -travellersNegatif[cptN].balance
                }
            }
            
        }
        }
        
        return results
    }
    
    //-------------------------------------------------------------------------------------------------
    // MARK: - TableViewDataSource
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return getRefunds().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        // Fetch a cell of the appropriate type.
        let cell = travellerTV.dequeueReusableCell(withIdentifier: "cellBalance", for: indexPath) as! RefundInBalanceCell
        
        // Configure the cell’s contents
        cell.textLabel!.text = self.getRefunds()[indexPath.row].refundDescription()
        cell.refund = self.getRefunds()[indexPath.row]
        cell.refundTVController = self
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        return "Remboursement"
    }
}

