//
//  MyTextFieldDelegate.swift
//  PayMe
//
//  Created by Alia Chawaf on 02/04/2019.
//  Copyright © 2019 Chawaf Alia & Gestin Rémi. All rights reserved.
//

import UIKit
import Foundation

class MyTextFieldDelegate: NSObject, UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print("test delegate")
        
        // hide keybord
        textField.resignFirstResponder()
        
        return true
    }

}
