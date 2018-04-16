//
//  ImageViewerVC.swift
//  DocumentViewer
//
//  Created by Jake Swedenburg on 4/15/18.
//  Copyright © 2018 Jake Swedenburg. All rights reserved.
//

import UIKit

class ImageViewerVC: UIViewController {

    @IBOutlet weak var docImage: UIImageView!
    
    var document: Document?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        downloadImage()
        
    }
    
    func downloadImage() {
        guard let doc = document else { return }
        let session = URLSession(configuration: .default)
        let url = URL(string: doc.url)!
        session.dataTask(with: url) { (data, response, error) in
            if let data = data {
                DispatchQueue.main.async {
                    self.docImage.image = UIImage(data: data)
                }
            }
        }.resume()
    }

    

}
