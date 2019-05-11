//
//  AQITests.swift
//  AQITests
//
//  Created by sean on 2019/5/8.
//  Copyright © 2019 sean. All rights reserved.
//

import XCTest
@testable import AQI

class AQITests: XCTestCase {
    var httpClient: HttpClient!
    let mockSession = MockURLSession()
    let session = URLSession(configuration: URLSessionConfiguration.default)
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        super.setUp()
    
    }

    override func tearDown() {
        super.tearDown()
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    // Testing Tools/DataParser/dataToJsonArray
    // Desc: With worng struct
    func test_dataToJsonArray(){
        let stringData = "abcdefghijk123123123".data(using: .utf8)
        let results = dataToJsonArray(data: stringData)
        XCTAssert(results.count == 0)
        
    }
    
    // Testing Tools/DataParser/dataToJsonArray
    // Desc: With correct struct
    func test_dataToJsonArray_with_JsonArray(){
        let stringData = "[{\"abc\":\"123\"},{\"abc\":\"456\"},{\"abc\":\"789\"}]".data(using: .utf8)
        let results = dataToJsonArray(data: stringData)
        XCTAssert(results.count == 3)
        
    }
    // Testing Tools/DataParser/dataToString
    // Desc: With correct struct
    func test_dataToString(){
        let stringData = "abcdefghijk123123123".data(using: .utf8)
        let result = dataToString(data: stringData)
        XCTAssert(result == "abcdefghijk123123123")
        
    }
    // Testing Network/HttpClient/get
    // Desc: The result is in expectation or not.
    func test_get_top_10_AQI(){
        let AQITop10: String = "https://opendata.epa.gov.tw/webapi/Data/REWIQA/?$orderby=SiteName&$skip=0&$top=10&format=json"
        httpClient = HttpClient(session: session)
        guard let url = URL(string: AQITop10) else {
            fatalError("URL can't be empty")
        }
        
        let urlExpectation = expectation(description: "GET \(AQITop10)")
        
        httpClient.get(url: url) { (data, response, error) in
            let jsonArray = dataToJsonArray(data: data!)
            print("\(jsonArray)")
            XCTAssert(jsonArray.count == 10)
            urlExpectation.fulfill()
        }
        waitForExpectations(timeout: 10, handler: nil)
        
    }
    // Testing Network/HttpClient/get
    // Func: The url we input is in expectation or not.
    func test_get_request_with_URL() {
        httpClient = HttpClient(session: mockSession)
        
        guard let url = URL(string: "https://mockurl") else {
            fatalError("URL can't be empty")
        }
        
        httpClient.get(url: url) { (data, response, error) in
            
        }
        
        XCTAssert(mockSession.lastURL == url)
        
    }
    // Testing Network/HttpClient/get
    // Func: The behavior of the datatask is in expectation or not.
    func test_get_resume_called() {
        httpClient = HttpClient(session: mockSession)
        let dataTask = MockURLSessionDataTask()
        mockSession.nextDataTask = dataTask
        
        guard let url = URL(string: "https://mockurl") else {
            fatalError("URL can't be empty")
        }
        
        httpClient.get(url: url) { (data, response, error) in
            
        }
        
        XCTAssert(dataTask.resumeWasCalled)
    }

}
