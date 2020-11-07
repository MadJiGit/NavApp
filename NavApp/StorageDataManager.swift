//
//  StorageData.swift
//  NavApp
//
//  Created by Madji on 6.11.20.
//  Copyright © 2020 Madji. All rights reserved.
//

import FirebaseStorage

class StorageDataManager {
    
    static let shared = StorageDataManager()
    
    var uid: String?
    var photoUrlString: String?
    var profileImage: UIImage?
    
//    func setStorageData(user: FirebaseAuth.User!){
//        self.uid = user.uid
//        self.photoUrlString = user.photoUrlString
//        
//        loadStorageRef()
//    }
    
    private init() {}
}

extension StorageDataManager {
    
    private func loadStorageRef(){
        let storage = Storage.storage()
        let storageRef = storage.reference()
        let imagePhotoUrl = storageRef.child("avatars/\(uid).jpg")
        
        loadProfileImage(imagePhotoUrl: imagePhotoUrl)
    }
    
    private func loadProfileImage(imagePhotoUrl: StorageReference){
        
        
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
                
                if self.profileImage != UIImage(data: unwrappedData) {
                    print("No image data")
                    return
                }
            }
        }
    }
    
    func getStorageData() -> StorageDataManager {
        return StorageDataManager.shared
    }
    
    func getCurrentUserProfileImage() -> UIImage {
        return self.profileImage!
    }
    
}
