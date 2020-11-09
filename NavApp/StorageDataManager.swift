//
//  StorageData.swift
//  NavApp
//
//  Created by Madji on 6.11.20.
//  Copyright © 2020 Madji. All rights reserved.
//

import FirebaseStorage
import FirebaseAuth

typealias ImageLoadingHandler = (Bool) -> Void
typealias ImageReadyHandler = (Bool) -> Void

class StorageDataManager {
    
    static let shared = StorageDataManager()
    
    static private var isStorageDataExist = false
    var photoUrlString: String?
    var profileImage: UIImage?
    
    private init() {}
    
}

extension StorageDataManager {
    
    func loadStorageRef(completion: @escaping ImageReadyHandler){
        guard let userId = Auth.auth().currentUser?.uid else {
            completion(false)
            print("No user ID")
            return
        }
        let storage = Storage.storage()
        let storageRef = storage.reference()
        let imagePhotoUrl = storageRef.child("avatars/\(userId).jpg")
        
        loadProfileImage(imagePhotoUrl: imagePhotoUrl) { (success: Bool)
            in if success {
                print("load image")
                completion(true)
            } else {
                completion(false)
                print("not load image")
            }
        }
    }
    
    func loadProfileImage(imagePhotoUrl: StorageReference, completion:
    @escaping ImageLoadingHandler) {
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
                
                if image == nil {
                    print("No image data")
                    return
                }
        
                self.profileImage = image
                completion(true)
                
            }
        }
        
        StorageDataManager.isStorageDataExist = true
        
    }
    
    func getStorageData() -> StorageDataManager {
        return StorageDataManager.shared
    }
    
    func getCurrentUserProfileImage() -> UIImage? {
        return self.profileImage
    }
    
}
