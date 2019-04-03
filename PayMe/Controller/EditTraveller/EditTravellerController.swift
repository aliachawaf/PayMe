//
//  EditTravellerController.swift
//  PayMe
//
//  Created by Alia Chawaf on 31/03/2019.
//  Copyright © 2019 Chawaf Alia & Gestin Rémi. All rights reserved.
//

import UIKit

class EditTravellerController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var firstname: UITextField!
    @IBOutlet weak var lastname: UITextField!
    @IBOutlet weak var arrivalDate: UIDatePicker!
    @IBOutlet weak var departureDate: UIDatePicker!
    
    var traveller: Traveller?
    
    override func viewDidLoad() {
        firstname.text = self.traveller?.firstname
        lastname.text = self.traveller?.lastname
        arrivalDate.date = (self.traveller?.arrivalDate)!
        departureDate.date = (self.traveller?.departureDate)!
        
        self.firstname.delegate = self
        self.lastname.delegate = self
    }
    
    
    //-------------------------------------------------------------------------------------------------
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "okEditTraveller" {
            
            self.traveller?.updateTravellerInfos(firstname: self.firstname.text!, lastname: self.lastname.text!, arrivalDate: self.arrivalDate.date, departureDate: self.departureDate.date)
            
            CoreDataManager.save()
            self.dismiss(animated: true, completion: nil)
        }
        else{
            self.dismiss(animated: false, completion: nil)
        }
    }
    
    //-------------------------------------------------------------------------------------------------
    // MARK: - TextFieldDelegate
    
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
