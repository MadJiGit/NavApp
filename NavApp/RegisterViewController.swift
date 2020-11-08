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
    
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var repeatPasswordField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func regButtonTapped(_ sender: UIButton) {
        
        guard checkDataIsValid() else {
            return
        }
        
        guard let email = emailField.text, let password = passwordField.text, let repeatPassword = repeatPasswordField.text else {
            return
        }
        
        AuthDataManager.registerUser(with: email, password: password) { (success: Bool, error: Error?) in
            if success {
                /* Method to redirect ot login */
//                self.loginUser(email: email, password: password)
                self.redirectToHomePage()
            } else if let error = error as NSError? {
                self.showError(error)
            }
    
            return
        }
    }
}

extension RegisterViewController {
    
    
    func loginUser(email: String, password: String) {
        self.redirectToHomePage()
        /*
         /* Method for redirect to login */
        AuthDataManager.loginUser(with: email, password: password) { (success: Bool, error: Error?) in
            if success {
                self.redirectToHomePage()
            } else if let error = error as NSError? {
                self.showError(error)
            }
        }
         */
    }
    
    func showError(_ error: NSError) {
        switch error.code {
        case AuthErrorCode.emailAlreadyInUse.rawValue:
            print("Email is already used")
        case AuthErrorCode.invalidEmail.rawValue:
            print("Email is already used")
        case AuthErrorCode.weakPassword.rawValue:
            print("Use strong password")
        case AuthErrorCode.invalidEmail.rawValue,
             AuthErrorCode.wrongPassword.rawValue:
            print("Wrong pass or email")
        default:
            print("error")
        }
    }
    
    func checkDataIsValid() -> Bool {
        
        guard emailField.hasText, passwordField.hasText, repeatPasswordField.hasText else {
            alert(message: "Fill correctly fields!", title: "Fill FIelds")
            print("Fill all fields")
            return false
        }
        
        guard let email = emailField.text, let password = passwordField.text, let repeatPassword = repeatPasswordField.text else {
            print("error")
            return false
        }
        
        
        if ((0 != password.compare(repeatPassword).rawValue) && false == email.isEmpty) {
            alert(message: "Password and repeat password must match!", title: "Password missmatch")
            print("Password and repeat password must match.")
            return false
        }
        
        return true
    }
    
    private func redirectToHomePage(){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let mainTabBarController = storyboard.instantiateViewController(identifier: "MainTabBarController")
        (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(mainTabBarController)
    }
}
