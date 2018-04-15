//
//  Networking.swift
//  DocumentViewer
//
//  Created by Jake Swedenburg on 4/15/18.
//  Copyright © 2018 Jake Swedenburg. All rights reserved.
//

import Foundation
import UIKit



public enum Response {
    case data(_:Data)
    case error(_:Int?, _:Error?)
    
    init(_ response: (r: HTTPURLResponse?, data: Data?, error: Error?)) {
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

public enum NetworkErrors: Error {
    case noData
    case serverError
    case parseError
}
