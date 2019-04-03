//
//  DetailsTravellerController.swift
//  PayMe
//
//  Created by Alia Chawaf on 03/04/2019.
//  Copyright © 2019 Chawaf Alia & Gestin Rémi. All rights reserved.
//

import UIKit

class DetailsTravellerController: UIViewController {

    @IBOutlet weak var firstname: UILabel!
    @IBOutlet weak var lastname: UILabel!
    @IBOutlet weak var arrivalDate: UILabel!
    @IBOutlet weak var departureDate: UILabel!
    
    var traveller: Traveller?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.firstname.text = self.traveller?.firstname
        self.lastname.text = self.traveller?.lastname
        self.arrivalDate.text = self.traveller?.arrivalDate.description
        self.departureDate.text = self.traveller?.departureDate.description
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if segue.identifier == "editTraveller" {
            
            if let destController = segue.destination as? EditTravellerController {
                destController.traveller = self.traveller
            }
        }
    }
}
