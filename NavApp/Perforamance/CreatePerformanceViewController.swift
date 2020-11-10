//
//  CreatePerformanceViewController.swift
//  NavApp
//
//  Created by Madji on 9.11.20.
//  Copyright © 2020 Madji. All rights reserved.
//

import UIKit

class CreatePerformanceViewController: UIViewController {
    

    @IBOutlet weak var performanceImage: UIImageView!
    @IBOutlet weak var performanceTitle: UITextField!
    @IBOutlet weak var performanceDescription: UITextField!
    @IBOutlet weak var performanceTypePicker: UIPickerView!
    var privatePerformance = "Private"
    
//    var pickerData:[String] = [String]()
    
    var pickerView = UIPickerView()
    let pickerData = ["Item 1", "Item 2", "Item 3", "Item 4", "Item 5", "Item 6"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        performanceTypePicker.delegate = self
        performanceTypePicker.dataSource = self
    }
        
    // MARK: - Add Image Button
    @IBAction func addImageButtonTapped(_ sender: UIButton) {
        
        let imagePickerController = UIImagePickerController()
        
        imagePickerController.delegate = self
        imagePickerController.allowsEditing = true
        imagePickerController.mediaTypes = ["public.image"]
        
        present(imagePickerController, animated: true, completion: nil)
        
    }
    
    // MARK: - Chose Perforamance Status
    @IBAction func performancePrivateStatus(_ sender: UISegmentedControl) {
        
        let selected = sender.selectedSegmentIndex
        
        privatePerformance = (1 == selected) ? "Public" : "Private"
        
        print("UISegmentedControl selected index = \(privatePerformance)")
    }
    
    // MARK: - Share Button
    @IBAction func shareButtonTapped(_ sender: UIButton) {
    }
}

extension CreatePerformanceViewController: UIPickerViewDelegate, UIPickerViewDataSource {

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        print("\(pickerData[row])")
    }

}


extension CreatePerformanceViewController: UIImagePickerControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info:[UIImagePickerController.InfoKey : Any]) {
        
        guard let selectedImage = info[.editedImage] as? UIImage  else {
            print("Image picker could not select image")
            return
            
        }
        
        performanceImage.image = selectedImage
        
        picker.dismiss(animated: true, completion: nil)
    }

}

extension CreatePerformanceViewController: UINavigationControllerDelegate {
    
}
