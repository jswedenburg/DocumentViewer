//
//  DocumentDetailVC.swift
//  DocumentViewer
//
//  Created by Jake Swedenburg on 4/15/18.
//  Copyright © 2018 Jake Swedenburg. All rights reserved.
//

import UIKit

class DocumentDetailVC: UIViewController {
    
    var document:Document?

    override func viewDidLoad() {
        super.viewDidLoad()
        showDocContent()
        setupUI()
        
    }
    
    //MARK: Setup
    func setupUI() {
        let navFont = UIFont(name: "Roboto-Regular", size: 20)!
        self.navigationController?.title = document?.name
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.font : navFont, NSAttributedStringKey.foregroundColor: UIColor.documentDarkGray()]
        self.navigationController?.navigationBar.tintColor = UIColor.documentDarkGray()
        
        self.navigationItem.title = document?.name
        
        let barFont = UIFont(name: "Roboto-Regular", size: 18)!
        let rightItem = UIBarButtonItem(title: document?.size, style: .plain, target: nil, action: nil)
        rightItem.setTitleTextAttributes([NSAttributedStringKey.font : barFont], for: .normal)
        self.navigationItem.rightBarButtonItem = rightItem
        
    }
    
    func showDocContent() {
        switch document!.type {
        case .image:
            let imageVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "imageVC") as! ImageViewerVC
            imageVC.document = document
            add(asChildViewController: imageVC)
        case .pdf:
            let pdfVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "pdfVC") as! PDFViewerVC
            pdfVC.document = document
            add(asChildViewController: pdfVC)
        }
    }
    
    //MARK: Helper
    private func add(asChildViewController child: UIViewController) {
        addChildViewController(child)
        view.addSubview(child.view)
        
        child.view.frame = view.bounds
        child.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        child.didMove(toParentViewController: self)
    }

    

}
