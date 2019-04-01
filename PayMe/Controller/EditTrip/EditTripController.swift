//
//  EditTripController.swift
//  PayMe
//
//  Created by Alia Chawaf on 31/03/2019.
//  Copyright © 2019 Chawaf Alia & Gestin Rémi. All rights reserved.
//

import UIKit

class EditTripController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var trip: Trip?
    let imagePicker = UIImagePickerController()
    
    @IBOutlet weak var nameTrip: UITextField!
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        
        //set name TextField
        self.nameTrip.text = trip?.name
        
        //set ImageView
        if let dataImage = trip?.image {
            self.imageView.image = UIImage(data: dataImage)
        } else {
            self.imageView.image = #imageLiteral(resourceName: "addimage")
        }
        
        imagePicker.delegate = self
    }
    
    @IBAction func handleTapImage(_ sender: Any) {
        imagePicker.allowsEditing = true
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
    
    
    //-------------------------------------------------------------------------------------------------
    // MARK: - ImagePickerControllerDelegate
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            imageView.contentMode = .scaleAspectFit
            imageView.image = pickedImage
        }
        
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    //-------------------------------------------------------------------------------------------------
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "okEditTrip" {
            
            self.trip?.updateTripInfos(newName: nameTrip.text!, newImage: (imageView.image?.jpegData(compressionQuality: 1))!)
           
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
