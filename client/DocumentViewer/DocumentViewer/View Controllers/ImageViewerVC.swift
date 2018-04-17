//
//  ImageViewerVC.swift
//  DocumentViewer
//
//  Created by Jake Swedenburg on 4/15/18.
//  Copyright © 2018 Jake Swedenburg. All rights reserved.
//

import UIKit
import PKHUD

class ImageViewerVC: UIViewController {
    
    @IBOutlet weak var docImage: UIImageView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var document: Document?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        downloadImage()
    }
    
    func downloadImage() {
        activityIndicator.startAnimating()
        guard let doc = document else { return }
        let session = URLSession(configuration: .default)
        let url = URL(string: doc.url)!
        session.dataTask(with: url) { (data, response, error) in
            DispatchQueue.main.async {
                self.activityIndicator.stopAnimating()
                if let data = data {
                    self.docImage.image = UIImage(data: data)
                } else {
                    HUD.flash(HUDContentType.error)
                }
            }
            }.resume()
    }
    
    
    
}
