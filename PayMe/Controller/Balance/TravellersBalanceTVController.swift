//
//  TravellersBalanceTVController.swift
//  PayMe
//
//  Created by Alia Chawaf on 03/04/2019.
//  Copyright © 2019 Chawaf Alia & Gestin Rémi. All rights reserved.
//

import UIKit

class TravellersBalanceTVController: NSObject, UITableViewDataSource, UITableViewDelegate {
    
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
    
   
    
    //-------------------------------------------------------------------------------------------------
    // MARK: - TableViewDataSource
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return travellerViewModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        tableView.allowsSelection = false
        
        // Fetch a cell of the appropriate type.
        let cell = travellerTV.dequeueReusableCell(withIdentifier: "cellTypeIdentifier", for: indexPath) as! TravellerBalanceCell
        
        // Configure the cell’s contents
        cell.textLabel!.text = (self.travellerViewModel.get(travellerAt: indexPath.row)?.fullname())!
        
        let balance = self.travellerViewModel.get(travellerAt: indexPath.row)!.balance
        
        cell.balance.text = String(balance) + " €"
        
        if balance < 0 {
            cell.balance.backgroundColor = #colorLiteral(red: 1, green: 0.4033368393, blue: 0.4369280409, alpha: 1)
        } else {
            cell.balance.backgroundColor = #colorLiteral(red: 0.6474267826, green: 1, blue: 0.6095485427, alpha: 1)
        }
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    //-------------------------------------------------------------------------------------------------
    // MARK: - TableViewDelegate
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        let n = travellerViewModel.count
        
        if  n > 1 {
            return String(n) + " Voyageurs"
        } else {
            return String(n) + " Voyageur"
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        
        view.tintColor = #colorLiteral(red: 0.7509321217, green: 0.8862745166, blue: 0.8517355244, alpha: 1)
    }
}
