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
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
        
    // MARK: - Add Image Button
    @IBAction func addImageButtonTapped(_ sender: UIButton) {
    }
    
    // MARK: - Chose Perforamance Status
    @IBAction func performancePrivateStatus(_ sender: UISegmentedControl) {
    }
    
    // MARK: - Share Button
    @IBAction func shareButtonTapped(_ sender: UIButton) {
    }
    

}
