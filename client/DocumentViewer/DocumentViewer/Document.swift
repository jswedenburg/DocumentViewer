//
//  Document.swift
//  DocumentViewer
//
//  Created by Jake Swedenburg on 4/14/18.
//  Copyright © 2018 Jake Swedenburg. All rights reserved.
//

import UIKit

enum DocumentType: String, Decodable {
    case pdf
    case image
}

struct DocumentList:Decodable {
    let documents:[Document]
}

struct Document: Decodable {
    
    let id:String
    let name:String
    let type:DocumentType
    let size: String
    let url:String
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case type = "type"
        case size = "size"
        case url = "self"
    }
}
