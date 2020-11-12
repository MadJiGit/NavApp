//
//  PerformanceManager.swift
//  NavApp
//
//  Created by Madji on 10.11.20.
//  Copyright © 2020 Madji. All rights reserved.
//

import Foundation
import FirebaseAuth
import FirebaseStorage

/*
Take an image or select from media gallery
Set type, solo, cipher, challenge
Set a #tag (#holiday, #bbq, #pool, #fitness, #hiking, etc.)
Set sharing to followers, list of users, private, public
Publish, upload to storage
 */


class PerformanceManager {
    
    var performanceTypesCollection: String?
    var performanceImageUrlString: URL?
    var performanceImage: UIImage?
    var performanceTitle: String?
    var performanceTagsCollection: [String]?
    var performanceUid: String?
    var performancePrivateOrPublic: String?

    
    init (_ typesCollection: String?,
          _ imageUrlString: URL?,
          _ image: UIImage?,
          _ title: String?,
          _ tagsCollection: [String]?,
          _ uid: String?,
          _ privateOrPublic: String?) {
        self.setPerformanceTypesCollection(typesCollection!)
        self.setPerformanceImageUrl(imageUrlString!)
        self.setPerforamanceImage(image!)
        self.setPerformanceTitle(title!)
        self.setPerformanceTagsCollection(tagsCollection!)
        self.setPerformanceUid(uid!)
        self.setPerformancePriveOrPublic(privateOrPublic!)
    }
    
}

extension PerformanceManager {
    
    func getPerformanceTypesCollection() -> String {
        return performanceTypesCollection!
    }
    
    func getPerformanceUid() -> String {
        return "1"
    }
    
    func setPerformanceTypesCollection( _ type: String){
        performanceTypesCollection = type
    }
    
    func setPerformanceUid(_ uid: String) {
        performanceUid = uid
    }
    
    func setPerformanceTitle(_ title: String) {
        performanceTitle = title
    }
    
    func setPerforamanceImage(_ image: UIImage) {
        performanceImage = image
    }
    
    func setPerformanceImageUrl(_ url: URL) {
        performanceImageUrlString = url
    }
    
    func setPerformancePriveOrPublic(_ status: String) {
        performancePrivateOrPublic = status
    }
    
    func setPerformanceTagsCollection(_ collections: [String]) {
        performanceTagsCollection = collections
    }
}
