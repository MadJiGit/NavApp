//
//  RegisterViewController.swift
//  NavApp
//
//  Created by Madji on 5.10.20.
//  Copyright © 2020 Madji. All rights reserved.
//

import UIKit
import FirebaseFirestore
import FirebaseAuth

class RegisterViewController: UIViewController {
    
    var db: Firestore!
    
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var repeatPasswordField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        db = Firestore.firestore()
    }
    
    @IBAction func regButtonTapped(_ sender: UIButton) {
        
        guard emailField.hasText, passwordField.hasText, repeatPasswordField.hasText
            else {
                alert(message: "Fill correctly fields!", title: "Fill FIelds")
                print("Fill all fields")
                return
        }
        

        let res = passwordField != repeatPasswordField
        if (!res) {
            alert(message: "Password and repeat password must match!", title: "Password missmatch")
            print("Password and repeat password must match.")
            return
        }
        
        Auth.auth().createUser(withEmail: emailField.text!, password: passwordField.text!) { authResult, error in
            
            if error != nil {
                print("Register Auth() error!")
            } else {
                print("Register succes")
            }
        }
        
        return
    }
    
    
}
