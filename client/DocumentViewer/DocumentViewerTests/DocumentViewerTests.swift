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
    var testData:Data!
    
    override func setUp() {
        super.setUp()
        testSession = URLSession(configuration: .default)
        let file = Bundle(for: type(of: self)).path(forResource: "docs", ofType: "json")
        let url = URL(fileURLWithPath: file!)
        testData = try! Data(contentsOf: url)
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        testSession = nil
        testData = nil
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testParsing() {
        let decoder = JSONDecoder()
        let docList = try? decoder.decode(DocumentList.self, from: testData)
        let docs = docList?.documents
        XCTAssertEqual(docs?.count, 4, "Four docs parsed and created")
    }
    
    func testDocumentsAPICallToServer() {
        let promise = expectation(description: "response recieved")
        let manager = NetworkManager(session: testSession)
        manager.dataRequestForUrl(url: "http://localhost:3000/api/documents") { (error, data) in
            if error == nil {
                promise.fulfill()
            } else {
                XCTFail("api call failed)")
                promise.fulfill()
            }
        }
        waitForExpectations(timeout: 5, handler: nil)
    }
    
}
