//
//  StorageData.swift
//  NavApp
//
//  Created by Madji on 6.11.20.
//  Copyright © 2020 Madji. All rights reserved.
//

import FirebaseStorage
import FirebaseAuth

class StorageDataManager {
    
    static let shared = StorageDataManager()
    
    static private var isStorageDataExist = false
    var photoUrlString: String?
    var profileImage: UIImage?
    
    private init() {}
    
}

extension StorageDataManager {
    
    private func loadStorageRef(){
        guard let userId = Auth.auth().currentUser?.uid else {
            print("No user ID")
            return
        }
        let storage = Storage.storage()
        let storageRef = storage.reference()
        let imagePhotoUrl = storageRef.child("avatars/\(userId).jpg")
        
        loadProfileImage(imagePhotoUrl: imagePhotoUrl)
        
    }
    
    private func loadProfileImage(imagePhotoUrl: StorageReference) {
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
                
                let image = UIImage(data: unwrappedData)
                
                if self.profileImage == nil {
                    print("No image data")
                    return
                }
                
                self.profileImage = image
                
            }
        }
        
        StorageDataManager.isStorageDataExist = true
        
    }
    
    func getStorageData() -> StorageDataManager {
        if false == StorageDataManager.isStorageDataExist {
            self.loadStorageRef()
        }
        return StorageDataManager.shared
    }
    
    func getCurrentUserProfileImage() -> UIImage? {
            return self.profileImage
    }
    
}
