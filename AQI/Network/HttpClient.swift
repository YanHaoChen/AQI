//
//  HttpClient.swift
//  AQI
//
//  Created by sean on 2019/5/9.
//  Copyright © 2019 sean. All rights reserved.
//

import Foundation



class HttpClient {
    typealias completeClosure = ( _ data: Data?, _ error: Error?)->Void
    private let session: URLSession
    init(session: URLSession = URLSession.shared) {
        self.session = session
    }
    func get( url: URL, callback: @escaping completeClosure ) {
        let request = NSMutableURLRequest(url: url)
        request.httpMethod = "GET"
        let task = session.dataTask(with: url) { (data, _, error) in
            
            callback(data, error)
        }
        task.resume()
    }
}

func jsonArrayParser(data: Data?) -> [Dictionary<String,Any>] {
    do {
        if let jsonArray = try JSONSerialization.jsonObject(with: data!, options : .allowFragments) as? [Dictionary<String,Any>]
        {
            return jsonArray
        } else {
            print("bad json")
            return [Dictionary<String,Any>]()
        }
    } catch let error as NSError {
        print(error)
        return [Dictionary<String,Any>]()
    }
}
