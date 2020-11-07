//
//  DataDocument.swift
//  
//
//  Created by Madji on 9.10.20.
//

import Foundation
import UIKit

class DataDocument {
    
    var uid: String
    var username: String?
    var avatarImage: String?
    var city: String?
    var country: String?
    var gender: String?
    var age: String?
    
    init (uid: String) {
        self.uid = uid
    }
}

