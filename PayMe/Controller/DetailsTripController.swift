//
//  DetailsTripController.swift
//  PayMe
//
//  Created by Alia Chawaf on 26/03/2019.
//  Copyright © 2019 Chawaf Alia. All rights reserved.
//

import UIKit

class DetailsTripController: UIViewController {
    
    @IBOutlet weak var name: UILabel!
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var travellersTableView: UITableView!
    
    @IBOutlet weak var finishedButton: UIBarButtonItem!
    
    var trip: Trip?
    var travellersTV: TravellerTableViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.name.text = trip?.name
        if let dataImage = trip?.image {
            self.imageView.image = UIImage(data: dataImage)
        } else {
            self.imageView.image = #imageLiteral(resourceName: "addimage")
        }
        
        if (self.trip!.isFinished()) {
            self.finishedButton.title = "Pas Fini"
        } else {
            self.finishedButton.title = "Fini"
        }
        
        self.travellersTV = TravellerTableViewController(tv: travellersTableView, trip: self.trip!)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.travellersTV!.dataSetChanged()
        //self.travellersTV = TravellerTableViewController(tv: travellersTableView, trip: self.trip!)
    }
    
    @IBAction func finished(_ sender: Any) {
        self.trip!.changeFinished()
        self.viewDidLoad()
        
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "addTraveller"{
            if let destController = segue.destination as? NewTravellerController {
                
                destController.trip = self.trip!
            }
        }
    }
    
    
    @IBAction func unwindToThisView(sender: UIStoryboardSegue) {
        if let newTravellerController = sender.source as? NewTravellerController {
            
            if let traveller = newTravellerController.newTraveller {
                
                print("\(traveller)")
                self.travellersTV!.travellerViewModel.add(traveller: traveller)
                
            }
        }
    }
    
    
}

