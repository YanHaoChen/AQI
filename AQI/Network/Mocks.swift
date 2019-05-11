//
//  MockURLSession.swift
//  AQI
//
//  Created by sean on 2019/5/11.
//  Copyright © 2019 sean. All rights reserved.
//

import Foundation

class MockURLSession: URLSessionProtocol {
    var nextDataTask = MockURLSessionDataTask()
    var nextData: Data?
    var nextResponse: URLResponse?
    var nextError: Error?
    private (set) var lastURL: URL?
    func dataTask(with request: URLRequest, completionHandler: @escaping DataTaskResult) -> URLSessionDataTaskProtocol {
        lastURL = request.url
        completionHandler(nextData, nextResponse, nextError)
        return nextDataTask
    }
    
}

class MockURLSessionDataTask: URLSessionDataTaskProtocol {
    private (set) var resumeWasCalled = false
    
    func resume() {
        resumeWasCalled = true
    }
}
