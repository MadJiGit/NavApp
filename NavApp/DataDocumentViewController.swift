//
//  SecondViewController.swift
//  NavApp
//
//  Created by Madji on 5.10.20.
//  Copyright © 2020 Madji. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore


class DataDocumentViewController: UIViewController {
    
    @IBOutlet weak var databaseInfoTextView: UITextView!
    
    var database: Firestore!
    private let dataDocumentName = "users"
    private var dataDocument: DataDocument?
    var arrDataDocument = [DataDocument]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        database = Firestore.firestore()
        extractDataDocument()
    }
}

extension DataDocumentViewController {
    
    private func extractDataDocument() {
        
        let docRef = database.collection(dataDocumentName)
        docRef.getDocuments { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    let dataFromQuery = document.data()
                    let dd = DataDocument(uid: document.documentID)
                    dd.username = dataFromQuery["username"] as? String
                    dd.age = dataFromQuery["age"] as? String
                    dd.avatarImage = dataFromQuery["image"] as? String
                    dd.gender = dataFromQuery["gender"] as? String
                    dd.city = dataFromQuery["city"] as? String
                    dd.country = dataFromQuery["country"] as? String
                    
                    self.arrDataDocument.append(dd)
                }
            }
            
            self.showAllData()
        }
    }
    
    
    private func showAllData(){
        
        databaseInfoTextView.text.removeAll()
        
        for doc in arrDataDocument {
            databaseInfoTextView.insertText("username => \(doc.username ?? "(N/A)")\n")
            databaseInfoTextView.insertText("age => \(doc.age ?? "(N/A)")\n")
            databaseInfoTextView.insertText("gender => \(doc.gender ?? "(N/A)")\n")
            databaseInfoTextView.insertText("avatarImage => \(doc.avatarImage ?? "(N/A)")\n")
            databaseInfoTextView.insertText("city => \(doc.city ?? "(N/A)")\n")
            databaseInfoTextView.insertText("country => \(doc.country ?? "(N/A)")\n")
            databaseInfoTextView.insertText(" ********************* \n")
            
            print(" ********************* ")
            print("username => \(doc.username ?? "(N/A)")")
            print("age => \(doc.age ?? "(N/A)")")
            print("gender => \(doc.gender ?? "(N/A)")")
            print("avatarImage => \(doc.avatarImage ?? "(N/A)")")
            print("city => \(doc.city ?? "(N/A)")")
            print("country => \(doc.country ?? "(N/A)")")
            print(" ********************* ")
            
        }
        
        
    }
    
    //    func showDataByID(by id: String) -> DataDocument {
    //
    //        var oneDD: DataDocument
    //
    //        return oneDD
    //    }
    
}
