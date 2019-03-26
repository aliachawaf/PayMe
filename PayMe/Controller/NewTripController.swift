//
//  NewTripController.swift
//  PayMe
//
//  Created by Alia Chawaf on 25/03/2019.
//  Copyright © 2019 Chawaf Alia & Gestin Rémi. All rights reserved.
//

import UIKit

class NewTripController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    

    @IBOutlet weak var name: UITextField!
    
    var newTrip: Trip?
    
    @IBOutlet weak var imageView: UIImageView!
    
    let imagePicker = UIImagePickerController()
    
    @IBAction func loadImage(_ sender: Any) {
        
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
        
        present(imagePicker, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagePicker.delegate = self
        // Do any additional setup after loading the view.
    }
    
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "okAddTrip" {
            let name : String  = self.name.text!
            
            if let imageData = imageView.image?.jpegData(compressionQuality: 1) {
                self.newTrip = Trip(name: name, finished: false, image: imageData)
            } else {
                self.newTrip = Trip(name: name, finished: false)
            }

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
