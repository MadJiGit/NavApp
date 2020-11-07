//
//  LoginViewController.swift
//  NavApp
//
//  Created by Madji on 5.10.20.
//  Copyright © 2020 Madji. All rights reserved.
//

import UIKit
import FirebaseFirestore
import FirebaseAuth

class LoginViewController: UIViewController {
    
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    private var authListener: AuthStateDidChangeListenerHandle?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGestureRecognizer)
    }
    

    @IBAction func buttonTapped(_ sender: UIButton) {
        
        guard emailField.hasText, passwordField.hasText
            else {
                alert(message: "Fill correctly fields!", title: "Fill FIelds")
                return
        }
        let email = emailField.text!
        let password = passwordField.text!
        
        dismissKeyboard()
        
        AuthentificationManager.loginUser(with: email, password: password) { (success: Bool, error: Error?) in
            if success {
                self.redirectToHomePage()
            } else if let error = error as NSError? {
                switch error.code {
                case AuthErrorCode.invalidEmail.rawValue,
                     AuthErrorCode.wrongPassword.rawValue:
                    print("Wrong pass or email")
                    self.redirectToLoginPage()
                default:
                    print("Error auth method")
                }
            }
        }
    }
    
    private func redirectToHomePage(){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let mainTabBarController = storyboard.instantiateViewController(identifier: "MainTabBarController")
        (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(mainTabBarController)
    }
    
    private func redirectToLoginPage(){
        print("Register page")
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let loginNavController = storyboard.instantiateViewController(identifier: "LoginNavController")
        (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(loginNavController)
    }
}






