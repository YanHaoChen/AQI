//
//  HttpClient.swift
//  AQI
//
//  Created by sean on 2019/5/9.
//  Copyright © 2019 sean. All rights reserved.
//

import Foundation



class HttpClient {
    typealias completeClosure = ( _ data: Data? , _  response: URLResponse?, _ error: Error?)->Void
    private let session: URLSessionProtocol
    init(session: URLSessionProtocol) {
        self.session = session 
    }
    func get( url: URL, headers: [String: String] = [String: String](), callback: @escaping completeClosure ) {
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        if !headers.isEmpty {
            for (key, value) in headers {
                request.setValue(value, forHTTPHeaderField: key)
            }
        }

        let task = self.session.dataTask(with: request) { (data, response, error) in
            callback(data, response, error)
        }
        task.resume()
    }
}




