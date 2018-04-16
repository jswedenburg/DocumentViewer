//
//  DocumentViewerTests.swift
//  DocumentViewerTests
//
//  Created by Jake Swedenburg on 4/14/18.
//  Copyright © 2018 Jake Swedenburg. All rights reserved.
//

import XCTest
@testable import DocumentViewer

class DocumentViewerTests: XCTestCase {
    
    var testSession:URLSession!
    var testController:DocumentListVC!
    
    override func setUp() {
        super.setUp()
        testController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "docListVC") as! DocumentListVC
        testSession = URLSession(configuration: .default)
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        testSession = nil
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testDocFetchingAndParsing() {
        let promise = expectation(description: "Docs Fetched")
        let manager = NetworkManager(session: testSession)
        XCTAssertEqual(testController.documents.count, 0, "Not at 0")
        manager.fetchAllDocuments { ( vfc, docs) in
            self.testController.documents = docs ?? []
            promise.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertEqual(testController.documents.count, 4, "Not at 4 documents after fetching")
    }
    
    func testDocumentsAPICallToServer() {
        let url = URL(string: "http://localhost:3000/api/documents")!
        
        let promise = expectation(description: "response recieved")
        
        testSession.dataTask(with: url) { (data, response, error) in
            let parsedResponse = Response((r: response as? HTTPURLResponse, data: data, error: error))
            switch parsedResponse {
            case .data(_):
                promise.fulfill()
            case .error(let code, let error):
                XCTFail("Failed with status code: \(String(describing: code)) and error: \(String(describing: error))")
                promise.fulfill()
            }
        }.resume()
        
        waitForExpectations(timeout: 10, handler: nil)
    }
    
}
