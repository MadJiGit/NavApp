//
//  ExtractDataBaseViewController.swift
//  NavApp
//
//  Created by Madji on 8.10.20.
//  Copyright © 2020 Madji. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore
import FirebaseStorage

class ExtractDataBaseViewController: UIViewController {
    
    var user: FirebaseAuth.User!
    var users = [User]()
    var database: Firestore!
    var dbName = "users"
    var username = "username"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        database = Firestore.firestore()
        loadUsers(dbName, username)
    }
    
    func loadUsers(_ dbName: String, _ username: String) {
        
        let docRef = database.collection(dbName)
        docRef.getDocuments { (querySnapshot, err) in
            if let docs = querySnapshot?.documents {
                for docSnapshot in docs {
                    if let result = docSnapshot.data()[username] as? String {
                        
                    }
                }
            }
        }
    }
}
