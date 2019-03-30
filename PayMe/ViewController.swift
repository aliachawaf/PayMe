//
//  ViewController.swift
//  PayMe
//
//  Created by Alia Chawaf on 24/03/2019.
//  Copyright © 2019 Chawaf Alia & Gestin Rémi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var TableViewController: TripTableViewController!
    var trip: Trip?
    
    @IBOutlet weak var tripTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.TableViewController = TripTableViewController(tv: tripTableView)
    }
    
    //-------------------------------------------------------------------------------------------------
    // MARK: - Navigation
    
    @IBAction func unwindToThisView(sender: UIStoryboardSegue) {
        if let newTripController = sender.source as? NewTripController {
            
            if let trip = newTripController.newTrip{
                self.TableViewController.tripViewModel.add(trip: trip)
                self.TableViewController.dataSetChanged()
                
                self.trip = trip
                
                if self.trip != nil {
                    print(trip.name)
                }
                
                performSegue(withIdentifier: "showTrip", sender: self)
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showTrip"{
            if let destController = segue.destination as? DetailsTripController {
                
                if let cell = sender as? UITableViewCell {
                    guard let index = self.tripTableView.indexPath(for: cell) else {return}
                    destController.trip = self.TableViewController.tripViewModel.get(tripAt: index.row)
                    
                }
                else if sender as? UIViewController == self {
                    destController.trip = self.trip
                    
                }
            }
        }
    }
}
