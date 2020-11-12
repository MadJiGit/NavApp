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
        
        getStorageData()
        getCurrentUser()
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let editProfileViewConroller = segue.destination as? EditProfileViewController {
            editProfileViewConroller.delegateEditProfile = self
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

    func reloadUserDataToProfileViewController(_ viewController: EditProfileViewController) {
        getCurrentUser()
    }
}

extension ProfileViewController {
    
    func replaceUserInfoText(_ name: String?, _ : UITextView ) {
        profileInfoTextView.text.removeAll(keepingCapacity: true)
        profileInfoTextView.insertText("Welcome, \(name ?? "")")
    }
    
    func showUserInfoImageView(){
        
        StorageDataManager.shared.loadStorageRef() {
            (success: Bool) in
            if success {
                self.loadedImage = StorageDataManager.shared.getCurrentUserProfileImage()
                self.profileInfoImageView.image = self.loadedImage
                print("showUserInfoImageView")
            }
        }
    }
    
    func getStorageData(){
        storage = StorageDataManager.shared.getStorageData()
    }
    
    func getCurrentUser(){
        user = UserDataManager.shared.getCurrentUser()
        if user?.displayName == nil {
            replaceUserInfoText(user!.email, profileInfoTextView)
        } else {
            replaceUserInfoText(user!.displayName, profileInfoTextView)
        }

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
