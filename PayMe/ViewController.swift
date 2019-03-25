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

    @IBOutlet weak var tripTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.TableViewController = TripTableViewController(tv: tripTableView)
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    // segue ViewControllerB -> ViewController
    @IBAction func unwindToThisView(sender: UIStoryboardSegue) {
        if let newTripController = sender.source as? NewTripController {
            //dataRecieved = sourceViewController.dataPassed
            if let trip = newTripController.newTrip{
                self.TableViewController.tripViewModel.add(trip: trip)
                self.TableViewController.dataSetChanged()
            } }
    }

}

