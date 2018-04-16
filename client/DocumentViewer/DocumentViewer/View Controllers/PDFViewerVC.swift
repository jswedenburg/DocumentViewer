//
//  PDFViewerVC.swift
//  DocumentViewer
//
//  Created by Jake Swedenburg on 4/15/18.
//  Copyright © 2018 Jake Swedenburg. All rights reserved.
//

import UIKit
import WebKit

class PDFViewerVC: UIViewController, WKNavigationDelegate {

    @IBOutlet weak var pdfWebView: WKWebView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var document:Document?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pdfWebView.navigationDelegate = self
        loadWebView()
        setupUI()
    }
    
    func setupUI() {
        //NavBar
        let navFont = UIFont(name: "Roboto-Regular", size: 24)!
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.font : navFont]
        self.navigationController?.title = document?.name
        
        let rightItem = UIBarButtonItem(title: document?.size, style: .plain, target: nil, action: nil)
        navigationItem.setRightBarButton(rightItem, animated: true) 
    }
    
    func loadWebView() {
        guard let doc = document else { return }
        let url = URL(string: doc.url)!
        activityIndicator.startAnimating()
        pdfWebView.load(URLRequest(url: url))
        
    }

    //MARK: Webview Delegate
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        activityIndicator.stopAnimating()
    }

}
