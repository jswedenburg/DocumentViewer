//
//  Networking.swift
//  DocumentViewer
//
//  Created by Jake Swedenburg on 4/15/18.
//  Copyright © 2018 Jake Swedenburg. All rights reserved.
//

import Foundation
import UIKit

typealias RequestClosure = (Error?, Data?) -> Void

class NetworkManager {
    
    let session:URLSession
    
    init(session:URLSession) {
        self.session = session
    }
    
    func dataRequestForUrl(url: String, completion: @escaping RequestClosure) {
        let url = URL(string: "http://localhost:3000/api/documents")!
        
        session.dataTask(with: url) { (data, response, error) in
            let parsedResponse = Response((r: response as? HTTPURLResponse, data: data, error: error))

            switch parsedResponse {
            case .data(let jsonData):
                completion(nil, jsonData)
            case .error(let statusCode, let error):
                print("Task failed with status code: \(statusCode?.description) and error: \(error)")
                completion(error, nil)
            }
            }.resume()
        
    }
}




