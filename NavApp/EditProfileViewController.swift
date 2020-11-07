//
//  EditProfileViewController.swift
//  NavApp
//
//  Created by Madji on 5.10.20.
//  Copyright © 2020 Madji. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore
import FirebaseStorage

@objc protocol EditProfileViewControllerDelegate {
    func reloadUserDataToProfileViewController(_ profileViewController: EditProfileViewController)
}

class EditProfileViewController: UIViewController {
    
    var user:                 UserDataManager?
    @IBOutlet weak var newUsernameField: UITextField!
    @IBOutlet weak var profileInfoTextView: UITextView!
    @IBOutlet weak var profileInfoImageView: UIImageView!
    var imageToUpload: UIImage!
//    var imagePicker = UIImagePickerController()
    
    var isImageSelected = false
    
    let storage = Storage.storage()
    
    weak var delegateTest: EditProfileViewControllerDelegate?
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        dismissKeyboard()
        hideKeyboardWhenTappedAround()
        
        getCurrUser()
        loadCurrentUserData()
    }
    
    @IBAction func choseProfilePictureButtonTapped(_ sender: UIButton) {
        
        let imagePickerController = UIImagePickerController()
        
        imagePickerController.delegate = self
        imagePickerController.allowsEditing = true
        imagePickerController.mediaTypes = ["public.image"]
        
        present(imagePickerController, animated: true, completion: nil)
    }
    
    
    @IBAction func saveProfileChangesButtonTapped(_ sender: Any) {
        
        dismissKeyboard()
        
        var unwrappedNewUSernameTextFiled = profileInfoTextView.text

        if newUsernameField.hasText && newUsernameField.text != "" {
              unwrappedNewUSernameTextFiled = newUsernameField.text
        }
        
        // MARK: - UIImage upload to storage
        
        if isImageSelected {
            loadImageData()
        }
        
        updateProfileInfo( name: unwrappedNewUSernameTextFiled)
        
    }
    
    @IBAction func backButtonTapped(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}


extension EditProfileViewController {
    
    func loadImageData() {
        guard let imageToUpload = profileInfoImageView.image else {
            print("No image available to upload")
            return
        }
        
        guard let imageData = imageToUpload.jpegData(compressionQuality: 0.5) else {
            print("No JPEG data to upload")
            return
        }
        
        guard let userId = user?.uid else {
            print("Missing userId for the image")
            return
        }
        
        let storageRef = storage.reference()
        let imagePhotoUrl = storageRef.child("avatars/\(userId).jpg")
        let imageMetadata = StorageMetadata()
        imageMetadata.contentType = "image/jpeg"
        imagePhotoUrl.putData(imageData, metadata: imageMetadata) {
            (storageMetadata, err) in
            
            guard let unwrappedMetadata = storageMetadata else {
                print("Could not upload the profile image")
                return
            }
            
            print("print smth EditProfileViewCOntroller \(String(describing: unwrappedMetadata.contentType?.count))")
        }
    }
    
    func loadCurrentUserData() {
        showDisplayNameTextView(user?.getCurrentUserDisplayName(), profileInfoTextView)
//        profileInfoImageView.image = user?.getCurrentUserProfileImage()
//        showProfileImageView(withImage: user?.getCurrentUserProfileImage(), profileInfoImageView)
    }
    
    func getCurrUser() {
        user =                 UserDataManager.shared.getCurrentUser()
    }
    
    func showDisplayNameTextView(_ name: String?, _ profileInfoTextView: UITextView ) {
        profileInfoTextView.text.removeAll(keepingCapacity: true)
        profileInfoTextView.insertText("\(name ?? "")")
    }
    
//    func showProfileImageView(withImage image: UIImage? = nil, withImageUrl imageUrl: String? = nil, _ profileInfoImageView: UIImageView ) {
//
//        if let image = image {
//            profileInfoImageView.image = user?.getCurrentUserProfileImage()
//        }
//        if let imageUrl {
//            profileInfoImageView.image = user?.getCurrentUserProfileString()
//        }
//
//    }
    
    
    func createProfileChangeRequest(photoUrl: URL? = nil, name: String? = nil, _ callback: ((Error?) -> ())? = nil){
        if let request = Auth.auth().currentUser?.createProfileChangeRequest(){
            if let name = name{
                request.displayName = name
            }
            if let url = photoUrl{
                request.photoURL = url
            }
            
            request.commitChanges { (error) in
                if error != nil {
                    print("Commit error!")
                    return
                } else {
                    self.delegateTest?.reloadUserDataToProfileViewController(self)
//                    self.showDisplayNameTextView(name, self.profileInfoTextView)
                    self.loadCurrentUserData()
                    
                }
            }
        }
    }
    
    func updateProfileInfo(withImage image: Data? = nil, name: String? = nil, _ callback: ((Error?) -> ())? = nil) {
        guard let user = Auth.auth().currentUser else {
            callback?(nil)
            return
        }
        
        if let image = image {
            let profileImgReference = Storage.storage().reference().child("profile_pictures").child("\(user.uid).png")
            
            _ = profileImgReference.putData(image, metadata: nil) { (metadata, error) in
                if let error = error {
                    callback?(error)
                } else {
                    profileImgReference.downloadURL(completion: { (url, error) in
                        if let url = url {
                            self.createProfileChangeRequest(photoUrl: url, name: name, { (error) in
                                callback?(error)
                            })
                        } else {
                            callback?(error)
                        }
                    })
                }
            }
        } else if let name = name {
            self.createProfileChangeRequest(name: name, { (error) in
                callback?(error)
            })
        } else {
            callback?(nil)
        }
        
    }
}

extension EditProfileViewController: UIImagePickerControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info:[UIImagePickerController.InfoKey : Any]) {
        
        guard let selectedImage = info[.editedImage] as? UIImage  else {
            print("Image picker could not select image")
            return
            
        }
        
        profileInfoImageView.image = selectedImage
        
        isImageSelected = true
        
        picker.dismiss(animated: true, completion: nil)
    }

}

extension EditProfileViewController: UINavigationControllerDelegate {
    
}

