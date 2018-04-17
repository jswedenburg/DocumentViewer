//
//  DocumentCellTableViewCell.swift
//  DocumentViewer
//
//  Created by Jake Swedenburg on 4/15/18.
//  Copyright © 2018 Jake Swedenburg. All rights reserved.
//

import UIKit

class DocumentTableViewCell: UITableViewCell {
    
    @IBOutlet weak var imgPreview: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblFileSize: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    
    func updateWith(doc: Document) {
        lblName.text = doc.name
        lblFileSize.text = doc.size
        switch doc.type {
        case .image:
            imgPreview.image = #imageLiteral(resourceName: "ic_pic")
        case .pdf:
            imgPreview.image = #imageLiteral(resourceName: "ic_pdf")
        }
    }

    

}
