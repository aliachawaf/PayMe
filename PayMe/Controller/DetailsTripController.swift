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
    
    /// called when trash button is clicked on
    ///
    /// - Parameter sender: trash button of the bottom navigation bar
    @IBAction func deleteTrip(_ sender: Any) {
        
        let alert = UIAlertController(title: "Etes-vous sûr de vouloir supprimer ce voyage ?", message: "", preferredStyle: .alert)
        
        // TO DO DELETE TRIP WHEN CLICKS YES !!!!
        alert.addAction(UIAlertAction(title: "Oui", style: .default, handler: nil))
        alert.addAction(UIAlertAction(title: "Non", style: .cancel, handler: nil))
        
        self.present(alert, animated: true)
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
