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
        
        waitForExpectations(timeout: 5, handler: nil)
    }
    
}
