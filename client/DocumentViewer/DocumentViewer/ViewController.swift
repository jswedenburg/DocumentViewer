//
//  ViewController.swift
//  DocumentViewer
//
//  Created by Jake Swedenburg on 4/14/18.
//  Copyright © 2018 Jake Swedenburg. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var documents:[Document] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getDocuments()
    }
    
    func getDocuments() {
        Document.getAllDocuments { (error, docs) in
            if let docs = docs {
                self.documents = docs
            }
        }
    }

    


}

