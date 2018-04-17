//
//  PDFViewerVC.swift
//  DocumentViewer
//
//  Created by Jake Swedenburg on 4/15/18.
//  Copyright © 2018 Jake Swedenburg. All rights reserved.
//

import UIKit
import WebKit
import PKHUD

class PDFViewerVC: UIViewController, WKNavigationDelegate {

    @IBOutlet weak var pdfWebView: WKWebView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var document:Document?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pdfWebView.navigationDelegate = self
        loadWebView()
    }
    
    //MARK: Setup
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
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        HUD.flash(HUDContentType.error)
    }
}
