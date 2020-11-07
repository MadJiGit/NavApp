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
//    private var storage: StorageData?
    
    var uid: String?
    var email: String?
    var displayName: String?
    var photoUrlString: String?
    var profileImage: UIImage?
    
    
    private init() {}
    
    func setUserData(user: FirebaseAuth.User!){
        self.uid = user.uid
        self.email = user.email
        self.displayName = user.displayName
        self.photoUrlString = user.photoURL?.absoluteString

//        loadStorageData(uid: uid!, photoUrlString: photoUrlString!)
    }
    

    
    func refreshUserData() {
        
        guard let reloadedUser = Auth.auth().currentUser else {
            print("Error trying to get curretn user")
            return
        }
        
        reloadedUser.reload(completion: {[weak self] (error) in
            if error != nil {
                print("Error reload user data")
                return
            }
        })
        
        
        self.email = reloadedUser.email
        self.displayName = reloadedUser.displayName
        self.photoUrlString = reloadedUser.photoURL?.absoluteString
    }
    
    
    
    
}

extension UserDataManager {
    
    func reloadUser(_ callback: ((Error?) -> ())? = nil){
        Auth.auth().currentUser?.reload(completion: { (error) in
            callback?(error)
        })
    }
    
//    func loadStorageData(uid: String, photoUrlString: String){
//        storage = StorageData.shared.setStorageData(uid: uid, photoUrlString: photoUrlString)
//    }
    
//    func getCurrentUserProfileImage() -> UIImage {
//
//        return storage!.getCurrentUserProfileImage()
//    }
    
    func getCurrentUser() ->                 UserDataManager {
        return                 UserDataManager.shared
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
    
    /*
    private func loadProfileImage(_ photoUrl: String?) {
        guard let userId = uid else {
            print("Error get userId")
            return
        }
        let storageRef = storage.reference()
        let imagePhotoUrl = storageRef.child("avatars/\(userId).jpg")
        
        imagePhotoUrl.getMetadata{ (metadata, err) in
            
            guard let metadata = metadata else {
                if err != nil {
                    print("Error loading photo")
                }
                
                return
            }
            
            imagePhotoUrl.getData(maxSize: metadata.size) { (data, err) in
                
                guard let unwrappedData = data else {
                    if err != nil {
                        print("Error loading photo")
                    }
                    
                    return
                }
                
                guard let profileImageTemp = UIImage(data: unwrappedData) else {
                    print("No image data")
                    return
                }
//                self.profileInfoImageView.image = loadedImage
                self.profileImage = profileImageTemp
                
            }
        }
    }
 */
    
}
