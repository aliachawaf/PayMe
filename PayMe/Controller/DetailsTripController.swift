//
//  DetailsTripController.swift
//  PayMe
//
//  Created by Alia Chawaf on 26/03/2019.
//  Copyright © 2019 Chawaf Alia & Gestin Rémi. All rights reserved.
//

import UIKit

class DetailsTripController: UIViewController {

    @IBOutlet weak var name: UILabel!
    
   var trip: Trip?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.name.text = trip?.name
    }
}
