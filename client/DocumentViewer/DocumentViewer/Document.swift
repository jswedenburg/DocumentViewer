//
//  Document.swift
//  DocumentViewer
//
//  Created by Jake Swedenburg on 4/14/18.
//  Copyright © 2018 Jake Swedenburg. All rights reserved.
//

import UIKit

typealias DocumentClosure = (Error?, [Document]?) -> Void

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
    
    static func getAllDocs(completion: @escaping DocumentClosure) {
        let url = "http://localhost:3000/api/documents"
        let manager = NetworkManager(session: URLSession(configuration: .default))
        manager.dataRequestForUrl(url: url) { (error, jsonData) in
            if error != nil {
                completion(error, nil)
                return
            }
            
            guard let data = jsonData else { completion(nil, nil)
                return }
            let decoder = JSONDecoder()
            do {
                let docList = try decoder.decode(DocumentList.self, from: data)
                completion(nil, docList.documents)
            } catch {
                completion(error, nil)
                print("Error parsing json: \(error)")
            }
        }
        
    }
}
