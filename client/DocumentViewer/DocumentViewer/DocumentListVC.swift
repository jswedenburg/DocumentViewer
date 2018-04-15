//
//  ViewController.swift
//  DocumentViewer
//
//  Created by Jake Swedenburg on 4/14/18.
//  Copyright © 2018 Jake Swedenburg. All rights reserved.
//

import UIKit

class DocumentListVC: UIViewController {

    @IBOutlet weak var docTableView: UITableView!
    
    var documents:[Document] = []
    let cellId:String = "documentCell"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getDocuments()
        setUpTableview()
        setupUI()
    }
    
    func setupUI() {
        //NavBar
        if let navFont = UIFont(name: "Roboto-Bold", size: 24) {
            self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.font : navFont]
        }
    }
    
    func setUpTableview() {
        docTableView.delegate = self
        docTableView.dataSource = self
    }
    
    func getDocuments() {
        Document.getAllDocuments { (error, docs) in
            if let docs = docs {
                DispatchQueue.main.async {
                    self.documents = docs
                    self.docTableView.reloadData()
                }
            }
        }
    }
}

extension DocumentListVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return documents.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = docTableView.dequeueReusableCell(withIdentifier: cellId) as? DocumentTableViewCell else { return UITableViewCell() }
        let doc = documents[indexPath.row]
        cell.updateWith(doc: doc)
        return cell
    }
}

