//
//  UserData.swift
//  NavApp
//
//  Created by Madji on 18.10.20.
//  Copyright © 2020 Madji. All rights reserved.
//

import Foundation
import UIKit
import FirebaseAuth
import FirebaseFirestore
import FirebaseStorage

class UserDataManager {
    
    static let shared = UserDataManager()
    
    static private var isUserDataExist = false
    var uid: String?
    var email: String?
    var displayName: String?
    var photoUrlString: String?
    var profileImage: UIImage?
    
    private init() {}
    
}

extension UserDataManager {
    
    func getCurrentUser() -> UserDataManager {
        if false == UserDataManager.isUserDataExist {
            self.loadUserData()
        }
        return UserDataManager.shared
    }
    
    private func loadUserData() {
        
        guard let currentUser = Auth.auth().currentUser else {
            print("Can't load current user")
            return
        }
        refreshData(from: currentUser)
    }
    
    private func refreshData(from fbUser: FirebaseAuth.User){
        uid = fbUser.uid
        email = fbUser.email
        displayName = fbUser.displayName
        photoUrlString = fbUser.photoURL?.absoluteString
    }
    
    
    func reloadUser(_ callback: ((Error?) -> ())? = nil){
        Auth.auth().currentUser?.reload(completion: { (error) in
            callback?(error)
        })
    }
    
    func getCurrentUserDisplayName() -> String {
        
        if  displayName != nil {
            return displayName!
        } else {
            return email!
        }
    }
    
    func getCurrenUserProfileImageString() -> String {
        return photoUrlString ?? ""
    }

    
    //    func refreshUserData() {
    //
    //        guard let reloadedUser = Auth.auth().currentUser else {
    //            print("Error trying to get curretn user")
    //            return
    //        }
    //
    //        reloadedUser.reload(completion: {[weak self] (error) in
    //            if error != nil {
    //                print("Error reload user data")
    //                return
    //            }
    //        })
    //
    //        self.email = reloadedUser.email
    //        self.displayName = reloadedUser.displayName
    //        self.photoUrlString = reloadedUser.photoURL?.absoluteString
    //    }
}
