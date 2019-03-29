//
//  NewTravellerController.swift
//  PayMe
//
//  Created by Alia Chawaf on 29/03/2019.
//  Copyright © 2019 Chawaf Alia & Gestin Rémi. All rights reserved.
//

import UIKit

class NewTravellerController: UIViewController, UITextFieldDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var firstname: UITextField!
    @IBOutlet weak var lastname: UITextField!
    @IBOutlet weak var arrivalDate: UIDatePicker!
    @IBOutlet weak var departureDate: UIDatePicker!
    
    public var newTraveller: Traveller?
    public var trip: Trip?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
 
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "okAddTraveller" {
            let firstname : String  = self.firstname.text!
            let lastname : String  = self.lastname.text!
            let arrivalDate : Date  = self.arrivalDate.date
            let departureDate : Date  = self.departureDate.date
            
            self.newTraveller = Traveller(firstname: firstname, lastname: lastname, arrival: arrivalDate, departure: departureDate, trip: self.trip!)

            self.dismiss(animated: true, completion: nil)
        }
        else{
            self.newTraveller = nil
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
