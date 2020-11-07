//
//  ProfileViewController.swift
//  NavApp
//
//  Created by Madji on 5.10.20.
//  Copyright © 2020 Madji. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore
import FirebaseStorage

class ProfileViewController: UIViewController {
    
    var user: UserDataManager?
    var storage: StorageDataManager?
    @IBOutlet weak var profileInfoTextView: UITextView!
    @IBOutlet weak var profileInfoImageView: UIImageView!
    
    var loadedImage: UIImage?
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
        
        getCurrUser()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let editProfileViewConroller = segue.destination as? EditProfileViewController {
            editProfileViewConroller.delegateTest = self
        }
    }
    
    
    @IBAction func logoutButtonTapped(_ sender: UIButton ) {
        
        _ = signOut()
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let loginNavController = storyboard.instantiateViewController(identifier: "LoginNavController")
        
        (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(loginNavController)
    }
}

extension ProfileViewController : EditProfileViewControllerDelegate {
    
    func reloadUserDataToProfileViewController(_ viewController: EditProfileViewController) { UserDataManager.shared.refreshUserData()
        getCurrUser()
    }
}

extension ProfileViewController {
    
    func replaceUserInfoText(_ name: String?, _ : UITextView ) {
        profileInfoTextView.text.removeAll(keepingCapacity: true)
        profileInfoTextView.insertText("Welcome, \(name ?? "")")
    }
    
    
//    func loadProfileImage(_ photoUrl: String?) {
//        guard let userId = user?.uid else {
//            print("Error get userId")
//            return
//        }
//        let storageRef = storage.reference()
//        let imagePhotoUrl = storageRef.child("avatars/\(userId).jpg")
//        
//        imagePhotoUrl.getMetadata{ (metadata, err) in
//            
//            guard let metadata = metadata else {
//                if err != nil {
//                    print("Error loading photo")
//                }
//                
//                return
//            }
//            
//            imagePhotoUrl.getData(maxSize: metadata.size) { (data, err) in
//                
//                guard let unwrappedData = data else {
//                    if err != nil {
//                        print("Error loading photo")
//                    }
//                    
//                    return
//                }
//                
//                if self.loadedImage != UIImage(data: unwrappedData) {
//                    print("No image data")
//                    return
//                }
////                self.profileInfoImageView.image = loadedImage
//            }
//        }
//    }
    
    func showUserInfoImageView(){
        
        if (self.loadedImage == nil) {
//            self.profileInfoImageView.image = loadedImage
//            self.profileInfoImageView.image = self.user?.getCurrentUserProfileImage()
        }
    }
    
    func getStorageData(){
        storage = StorageDataManager.shared.getStorageData()
    }
    
    func getCurrUser(){
        user = UserDataManager.shared.getCurrentUser()
        if user?.displayName == nil {
            replaceUserInfoText(user!.email, profileInfoTextView)
        } else {
            replaceUserInfoText(user!.displayName, profileInfoTextView)
        }
//        loadProfileImage(user?.photoUrlString)
        showUserInfoImageView()
    }
    
    func signOut() -> Bool{
        do {
            try Auth.auth().signOut()
            return true
        } catch {
            return false
        }
    }
}
