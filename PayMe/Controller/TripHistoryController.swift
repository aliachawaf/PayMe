//
//  TripHistoryController.swift
//  PayMe
//
//  Created by Alia Chawaf on 29/03/2019.
//  Copyright © 2019 Chawaf Alia & Gestin Rémi. All rights reserved.
//

import UIKit

class TripHistoryController: UIViewController {

    var TableViewHistoryController: TripHistoryTableViewController!
    
    @IBOutlet weak var tripHistoryTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.TableViewHistoryController = TripHistoryTableViewController(tv: tripHistoryTableView)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showTrip"{
            if let destController = segue.destination as? DetailsTripController {
                
                if let cell = sender as? UITableViewCell {
                    guard let index = self.tripHistoryTableView.indexPath(for: cell) else {return}
                    destController.trip = self.TableViewHistoryController.tripViewModel.get(tripAt: index.row)
                    
                }
            }
        }
    }
    
}
