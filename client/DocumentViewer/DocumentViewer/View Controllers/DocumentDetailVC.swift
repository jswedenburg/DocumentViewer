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
    
    private func add(asChildViewController child: UIViewController) {
        addChildViewController(child)
        view.addSubview(child.view)
        
        child.view.frame = view.bounds
        child.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        child.didMove(toParentViewController: self)
    }

    

}
