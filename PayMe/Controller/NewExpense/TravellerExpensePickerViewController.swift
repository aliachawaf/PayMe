//
//  TravellerExpensePickerViewController.swift
//  PayMe
//
//  Created by Alia Chawaf on 01/04/2019.
//  Copyright © 2019 Chawaf Alia & Gestin Rémi. All rights reserved.
//

import UIKit

class TravellerExpensePickerViewController: NSObject, UIPickerViewDataSource, UIPickerViewDelegate {
    
    var travellerPV: UIPickerView!
    var trip: Trip
    var travellerViewModel: TravellerViewModel
    var viewController: DetailsTripController?
    let fetchResultController : TravellerFetchResultsController
    
    init(pv: UIPickerView!, trip: Trip) {
        
        self.travellerPV = pv
        self.trip = trip
        self.fetchResultController = TravellerFetchResultsController(trip: self.trip)
        self.travellerViewModel = TravellerViewModel(data: self.fetchResultController.travellersFetched)
        
        super.init()
        self.travellerPV.dataSource = self
        self.travellerPV.delegate = self

    }
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return travellerViewModel.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return self.travellerViewModel.get(travellerAt: row)?.fullname()
    }
    
    

}
