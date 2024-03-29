//
//  DetailsTripController.swift
//  PayMe
//
//  Created by Alia Chawaf on 26/03/2019.
//  Copyright © 2019 Chawaf Alia. All rights reserved.
//

import UIKit

class DetailsTripController: UIViewController {
    
    @IBOutlet weak var nameTrip: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var travellersTableView: UITableView!
    @IBOutlet weak var finishedButton: UIBarButtonItem!
    @IBOutlet weak var totalAmountTrip: UILabel!
    
    
    @IBAction func handleShowExpenses(_ sender: Any) {
        performSegue(withIdentifier: "showExpenses", sender: self)
    }
    
    @IBAction func handleShowBalance(_ sender: Any) {
        performSegue(withIdentifier: "showBalance", sender: self)
    }
    
    var trip: Trip?
    var travellersTV: TravellerTableViewController!
    var travellerToEdit: Traveller?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // set trip name
        self.nameTrip.text = trip?.name
        
        // set trip image
        if let dataImage = trip?.image {
            self.imageView.image = UIImage(data: dataImage)
        } else {
            self.imageView.image = #imageLiteral(resourceName: "addimage")
        }
        
        // set finished or not finished button
        if (self.trip!.isFinished()) {
            self.finishedButton.title = "Pas Fini"
        } else {
            self.finishedButton.title = "Fini"
        }
        
        // set travellers data in the tableview
        self.travellersTV = TravellerTableViewController(tv: travellersTableView, trip: self.trip!)
        self.travellersTV.viewController = self
        
        self.totalAmountTrip.text = String(self.trip!.totalAmount!) + " €"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.travellersTV!.dataSetChanged()
    }
    
    /// called when finishedButton is clicked and change the finish state of the trip
    ///
    /// - Parameter sender: finishedButton of bottom bar
    @IBAction func changeFinished(_ sender: Any) {
        self.trip!.changeFinished()
        self.viewDidLoad()
    }
    
    //-------------------------------------------------------------------------------------------------
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "addTraveller"{
            if let destController = segue.destination as? NewTravellerController {
                
                destController.trip = self.trip!
            }
        }
        
        if segue.identifier == "editTrip" {
            
            if let destController = segue.destination as? EditTripController {
                destController.trip = trip
            }
        }
        
        if segue.identifier == "editTraveller" {
            
            if let destController = segue.destination as? EditTravellerController {
                destController.traveller = self.travellerToEdit
            }
        }
        
        if segue.identifier == "addExpense" {
            
            if let destController = segue.destination as? NewExpenseController {
                destController.trip = trip
            }
        }
        
        if segue.identifier == "showExpenses"{
            if let destController = segue.destination as? ListExpenseViewController {
                
                    destController.trip = self.trip
                    
            }
        }
        
        if segue.identifier == "showBalance"{
            if let destController = segue.destination as? BalanceController {
                
                destController.trip = self.trip
                
            }
        }
        
        if segue.identifier == "showTraveller"{
            if let destController = segue.destination as? DetailsTravellerController {
                
                if let cell = sender as? UITableViewCell {
                    guard let index = self.travellersTableView.indexPath(for: cell) else {return}
                    destController.traveller = self.travellersTV.travellerViewModel.get(travellerAt: index.row)
                    
                }
            }
        }
    }
    
    @IBAction func unwindToThisView(sender: UIStoryboardSegue) {
        if let newTravellerController = sender.source as? NewTravellerController {
            
            if let traveller = newTravellerController.newTraveller {
                self.travellersTV!.travellerViewModel.add(traveller: traveller)
            }
        }
        
        if sender.source is EditTripController {
            self.viewDidLoad()
        }
        
        
    }
}
