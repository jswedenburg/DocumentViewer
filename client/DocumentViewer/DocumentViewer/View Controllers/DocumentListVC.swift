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
    var filteredDocuments:[Document] = []
    let cellId:String = "documentCell"
    let detailSegueId:String = "segueToDetail"
    var searchController = UISearchController()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getDocuments()
        setUpTableview()
        setupUI()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == detailSegueId {
            let vc = segue.destination as? DocumentDetailVC
            let index = docTableView.indexPathForSelectedRow?.row ?? 0
            let selectedDoc = isFiltering() ? filteredDocuments[index] : documents[index]
            vc?.document = selectedDoc
        }
    }
    
    //MARK: Setup
    func setupUI() {
        //NavBar
        let navFont = UIFont(name: "Roboto-Regular", size: 24)!
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.font : navFont]
        
        
        
        //SearchBar
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Documents"
        navigationItem.searchController = searchController
        definesPresentationContext = true
        
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
        return isFiltering() ? filteredDocuments.count : documents.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = docTableView.dequeueReusableCell(withIdentifier: cellId) as? DocumentTableViewCell else { return UITableViewCell() }
        let doc = isFiltering() ? filteredDocuments[indexPath.row] : documents[indexPath.row]
        cell.updateWith(doc: doc)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: detailSegueId, sender: self)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension DocumentListVC: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let searchText = searchController.searchBar.text!
        filteredDocuments = documents.filter({ (doc) -> Bool in
            return doc.name.lowercased().contains(searchText.lowercased())
        })
        docTableView.reloadData()
    }
    
    func isFiltering() -> Bool {
        return searchController.isActive && !searchController.searchBar.text!.isEmpty
    }
    
    
}

