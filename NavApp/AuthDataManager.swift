//
//  AuthDataManager.swift
//  NavApp
//
//  Created by Madji on 18.10.20.
//  Copyright © 2020 Madji. All rights reserved.
//

import Foundation
import UIKit
import FirebaseFirestore
import FirebaseAuth

typealias AuthLoginHandler = (Bool, Error?) -> Void
typealias AuthRegisterHandler = (Bool, Error?) -> Void

class AuthDataManager {
    
    static private var isAuth = false
    
    private init() {}
    
    static func loginUser(with email: String?, password: String?, completion:  @escaping AuthLoginHandler) {
        
        guard let email = email, let password = password else {
            completion(false, nil)
            return
        }
        
        Auth.auth().signIn(withEmail: email, password: password) {
            authResult, error in
            
            guard let authResult = authResult else {
                print("Error with auth method")
                completion(false, error)
                return
            }
            
            isAuth = authResult.user != nil
            completion(true, nil)
        }
    }
    
    static func registerUser(with email: String?, password: String?, completion:
                                @escaping AuthRegisterHandler) {
        guard let email = email, let password = password else {
            completion(false, nil)
            return
        }
        
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            
            guard let authResult = authResult else {
                print("Error with auth method")
                completion(false, error)
                return
            }
            
            isAuth = authResult.user != nil
            completion(true, nil)
        }
    }
    
    static func isUserAuthenticated() -> Bool {
        return isAuth
    }
}





