//
//  ViewController.swift
//  DocumentViewer
//
//  Created by Jake Swedenburg on 4/14/18.
//  Copyright © 2018 Jake Swedenburg. All rights reserved.
//

import UIKit

class DocumentListVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var documents:[Document] = []
    var filteredDocuments:[Document] = []
    var searchController = UISearchController()
    let cellId:String = "documentCell"
    let detailSegueId:String = "segueToDetail"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchDocuments()
        setupUI()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let backItem = UIBarButtonItem()
        backItem.title = "Back"
        navigationItem.backBarButtonItem = backItem
        
        if segue.identifier == detailSegueId {
            let vc = segue.destination as? DocumentDetailVC
            let index = tableView.indexPathForSelectedRow?.row ?? 0
            let selectedDoc = isSearching() ? filteredDocuments[index] : documents[index]
            vc?.document = selectedDoc
        }
    }
    
    //MARK: Setup
    func setupUI() {
        
        //NavBar
        let navFont = UIFont(name: "Roboto-Regular", size: 20)!
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.font : navFont, NSAttributedStringKey.foregroundColor: UIColor.documentDarkGray()]
        
        //SearchBar
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Documents"
        navigationItem.searchController = searchController
        definesPresentationContext = true
        
        //Tableview
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    
    func fetchDocuments() {
        activityIndicator.startAnimating()
        Document.getAllDocs { (error, docs) in
            DispatchQueue.main.async {
                self.activityIndicator.stopAnimating()
                if error == nil {
                    self.documents = docs!
                    self.tableView.reloadData()
                }
            }
        }
    }
}

extension DocumentListVC: UITableViewDelegate, UITableViewDataSource {
    //Uses isSearching function to determine data source
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isSearching() ? filteredDocuments.count : documents.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellId) as? DocumentTableViewCell else { return UITableViewCell() }
        let doc = isSearching() ? filteredDocuments[indexPath.row] : documents[indexPath.row]
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
        tableView.reloadData()
    }
    
    func isSearching() -> Bool {
        return searchController.isActive && !searchController.searchBar.text!.isEmpty
    }
    
    
}

