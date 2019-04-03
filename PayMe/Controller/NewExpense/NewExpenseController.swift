//
//  NewExpenseController.swift
//  PayMe
//
//  Created by Alia Chawaf on 01/04/2019.
//  Copyright © 2019 Chawaf Alia & Gestin Rémi. All rights reserved.
//

import UIKit

class NewExpenseController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
    @IBOutlet weak var travellersCreatorsTV: UITableView!
    
    @IBOutlet weak var travellerConcernedTV: UITableView!
    
    @IBOutlet weak var nameExpense: UITextField!
    @IBOutlet weak var imageExpense: UIImageView!
    
    @IBOutlet weak var dateExpense: UIDatePicker!
    @IBOutlet weak var totalAmount: UILabel!
    var travellerTVController: TravellerExpenseTableViewController!
    var travellersCreatorTVController: TravellersCreatorTVController!
    
    var trip: Trip?
    var  newExpense: Expense?
    
    let imagePicker = UIImagePickerController()
    
    @IBAction func handleTapImage(_ sender: Any) {
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
    
    

    
    override func viewDidLoad() {
        
        self.travellersCreatorTVController = TravellersCreatorTVController(tv: travellersCreatorsTV, trip: trip!)
        self.travellersCreatorTVController.viewController = self

        self.travellerTVController = TravellerExpenseTableViewController(tv: travellerConcernedTV, trip: trip!)
        self.travellerTVController.viewController = self
        
        imagePicker.delegate = self
    }
    
    //-------------------------------------------------------------------------------------------------
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "okAddExpense" {
            
            let name = self.nameExpense.text!
            let imageData = self.imageExpense.image!.jpegData(compressionQuality: 1)!
            let date: Date = self.dateExpense.date
            
            let travellers = self.travellerTVController.travellerViewModel.getAll()!
            let amountCreator = self.travellersCreatorTVController.tabAmountCreator
            let amountConcerned = self.travellerTVController.amountConcerned
            
            self.newExpense = Expense(name: name, image: imageData, date: date, travellers: travellers, amountCreator: amountCreator, amountDept: amountConcerned)
        }
        else {
            
            
        }
    }
    

    
    //-------------------------------------------------------------------------------------------------
    // MARK: - ImagePickerControllerDelegate
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            self.imageExpense.contentMode = .scaleAspectFit
            self.imageExpense.image = pickedImage
        }
        
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}
