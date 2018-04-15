//
//  Document.swift
//  DocumentViewer
//
//  Created by Jake Swedenburg on 4/14/18.
//  Copyright © 2018 Jake Swedenburg. All rights reserved.
//

import Foundation
import UIKit

enum DocumentType {
    
}



typealias DocClosure = (Error?, [Document]?) -> Void



struct DocumentList:Decodable {
    let documents:[Document]
}

struct Document: Decodable {
    
    let id:String
    let name:String
    let type:String
    let size: String
    let url:String
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case type = "type"
        case size = "size"
        case url = "self"
    }
    
    static func getAllDocuments(completion: @escaping DocClosure) {
        let session = URLSession(configuration: .default)
        let url = URL(string: "http://localhost:3000/api/documents")!
        
        session.dataTask(with: url) { (data, response, error) in
            let parsedResponse = Response((r: response as? HTTPURLResponse, data: data, error: error))
            
            switch parsedResponse {
            case .data(let jsonData):
                let decoder = JSONDecoder()
                do {
                    let docList = try decoder.decode(DocumentList.self, from: jsonData)
                    completion(nil, docList.documents)
                } catch {
                    print("Error parsing json: \(error)")
                }
                
            case .error(let statusCode, let error):
                print("Task failed with status code: \(statusCode?.description) and error: \(error)")
                completion(error, nil)
            }
        }.resume()
        
    }
}
