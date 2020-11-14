//
//  CreatePerformanceViewController.swift
//  NavApp
//
//  Created by Madji on 9.11.20.
//  Copyright © 2020 Madji. All rights reserved.
//

import UIKit

class CreatePerformanceViewController: UIViewController {
    
//    var performanceData: PerformanceManager

    @IBOutlet weak var performanceImage: UIImageView!
   
    @IBOutlet weak var performanceTitleTextView: UITextView!
    @IBOutlet weak var performanceTagsTextView: UITextView!
    @IBOutlet weak var performanceTypePicker: UIPickerView!
    var privatePerformance = "Private"
    var pickerView = UIPickerView()
    var pickerData: [String] = [ "t1", "t2", "t3" ]
    var tags: [String] = [String]()
    var typeOfPerformance: String?
    var tagsOneString: String?
    var titleText: String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadPerformanceData()
        
        performanceTypePicker.delegate = self
        performanceTypePicker.dataSource = self
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let createPerformanceModalViewController = segue.destination as? CreatePerformanceModalViewController {
            createPerformanceModalViewController.delegatPerformanceModal = self
        }
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
        let text = "type\t\(typeOfPerformance)\nprivate\t\(privatePerformance)\ntitle\t\(titleText)\ntags\t\(tagsOneString)\n"
        alert(message: text)
    }
}

extension CreatePerformanceViewController : CreatePerformanceModalViewControllerDelegate {

    func passPerformanceDataToPerformanceViewController(_ tags: [String], _ titleText: String?){
        
        self.tags = tags
        self.titleText = titleText
        
        performanceTagsTextView.text = ""
        performanceTitleTextView.text = ""
        self.tagsOneString = self.tags.joined(separator: " ")
        
        performanceTagsTextView.text = self.tagsOneString
        performanceTitleTextView.text = self.titleText
    }
}

extension CreatePerformanceViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func loadPerformanceData() {
//        performanceData = PerformanceManager()
//        pickerData = performanceData.getPerformanceTypesCollection()
    }

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        self.typeOfPerformance = pickerData[row]
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
