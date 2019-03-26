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
    
    @IBOutlet weak var imageView: UIImageView!
    

    @IBAction func finished(_ sender: Any) {
       // self.trip!.changeFinished()
        
    }
    
    var trip: Trip?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.name.text = trip?.name
        if let dataImage = trip?.image {
            self.imageView.image = UIImage(data: dataImage)
        } else {
            self.imageView.image = #imageLiteral(resourceName: "addimage")
        }
        
    }
}

