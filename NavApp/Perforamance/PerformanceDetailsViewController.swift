//
//  PerformanceDetailsViewController.swift
//  NavApp
//
//  Created by Madji on 10.11.20.
//  Copyright © 2020 Madji. All rights reserved.
//

import UIKit

class PerformanceDetailsViewController: UIViewController {
    
    @IBOutlet weak var tagEntry: UITextField!
    @IBOutlet weak var tagsView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dismissKeyboard()
        hideKeyboardWhenTappedAround()

    }
    
    @IBAction func addButtonTapped(_ sender: UIButton) {
    }
    
    @IBAction func backButtonTapped(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    

}
