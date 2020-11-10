//
//  ExtensionViewController.swift
//  NavApp
//
//  Created by Madji on 9.10.20.
//  Copyright © 2020 Madji. All rights reserved.
//

import UIKit
import FirebaseFirestore
import FirebaseAuth
import FirebaseStorage

class ExtensionViewController: UIViewController {
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
    }
}

extension UIViewController {
    
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func alert(message: String, title: String = "") {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(OKAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
//    func reloadUser(_ callback: ((Error?) -> ())? = nil){
//        Auth.auth().currentUser?.reload(completion: { (error) in
//            callback?(error)
//        })
//    }
//
//    func getCurrentUserData() {
//        user = UserData.shared.getCurrentUser()
//    }
//
//    func getCurrentUserDisplayName() -> String {
//
//        if  user.displayName != nil {
//            return user.displayName!
//        } else {
//            return user.email!
//        }
//    }
//
//    func getCurrenUserProfileImage() -> String {
//
//    }
}

