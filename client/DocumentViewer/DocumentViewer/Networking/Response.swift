//
//  Response.swift
//  DocumentViewer
//
//  Created by Jake Swedenburg on 4/16/18.
//  Copyright © 2018 Jake Swedenburg. All rights reserved.
//

import UIKit

enum NetworkErrors:Error {
    case noData
    case badUrl
}

public enum Response {
    case data(_:Data)
    case error(_:Int?, _:Error?)
    
    init(_ response: (r: HTTPURLResponse?, data: Data?, error: Error?)) {
        if response.r?.statusCode == 404 {
            self = .error(response.r?.statusCode, NetworkErrors.badUrl)
            return
        }
        guard response.r?.statusCode == 200, response.error == nil else {
            self = .error(response.r?.statusCode, response.error)
            return
        }
        
        guard let data = response.data else {
            self = .error(response.r?.statusCode, NetworkErrors.noData)
            return
        }
        
        self = .data(data)
    }
}
