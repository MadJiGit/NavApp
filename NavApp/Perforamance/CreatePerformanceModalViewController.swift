//
//  CreatePerformanceModalViewController.swift
//  NavApp
//
//  Created by Madji on 12.11.20.
//  Copyright © 2020 Madji. All rights reserved.
//

import UIKit

@objc protocol CreatePerformanceModalViewControllerDelegate {
    func passPerformanceDataToPerformanceViewController(_ tags: [String], _ titleText: String?)
}

class CreatePerformanceModalViewController: UIViewController {
    
    @IBOutlet weak var titleFields: UITextField!
    @IBOutlet weak var tagsFields: UITextView!
    @IBOutlet weak var tagEntry: UITextField!
    var tags: [String] = []
    var titleText: String?
    
    weak var delegatPerformanceModal: CreatePerformanceModalViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Add Tag Button
    @IBAction func addButtonTapped(_ sender: UIButton) {
        if (tagEntry.hasText && tagEntry.text != "" ) {
            var temp: String = ""
            if (((tagEntry.text?.hasPrefix("#"))) == false){
                temp = "#" + tagEntry.text!
            } else {
                temp = tagEntry.text!
            }
            
            tagsFields.insertText(temp)
            tags.append(temp)
            tagEntry.text = ""
        } else {
            print("Tags no valid entry")
        }
    }
    
    
    // MARK: - Back Button
    @IBAction func backButtonTapped(_ sender: UIButton) {
        
        print("pass data from")
        titleText = titleFields.text
        
        delegatPerformanceModal?.passPerformanceDataToPerformanceViewController(tags, titleText)
        dismiss(animated: true, completion: nil)
    }
}



