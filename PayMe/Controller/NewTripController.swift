//
//  NewTripController.swift
//  PayMe
//
//  Created by Alia Chawaf on 25/03/2019.
//  Copyright © 2019 Chawaf Alia & Gestin Rémi. All rights reserved.
//

import UIKit

class NewTripController:UIViewController, UITextFieldDelegate {
    

    @IBOutlet weak var name: UITextField!
    
    var newTrip: Trip?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "okAddTrip" {
            let name : String  = self.name.text!
            
            self.newTrip = Trip(name: name, finished: false)
            self.dismiss(animated: true, completion: nil)
        }
        else{
            self.newTrip = nil
            self.dismiss(animated: false, completion: nil)

        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        //hide keybord
        textField.resignFirstResponder()
        
        if let text = textField.text{
            if text != ""{
                textField.resignFirstResponder()
                return true
            } }
        return false
        
    }
}
