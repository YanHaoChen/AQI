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
    private let session: URLSession
    init(session: URLSession = URLSession.shared) {

        self.session = session
    }
    func get( url: URL, callback: @escaping completeClosure ) {
        var request = URLRequest(url: url)
        
        request.httpMethod = "GET"
        request.addValue("https://tw.appledaily.com/recommend/realtime/", forHTTPHeaderField: "Referer")
        let task = self.session.dataTask(with: request) { (data, response, error) in
            callback(data, response, error)
        }
        task.resume()
    }
}

func requestWithURL(urlString: String, parameters: [String: Any], completion: @escaping (Data) -> Void){
    
    var urlComponents = URLComponents(string: urlString)!
    urlComponents.queryItems = []
    
    for (key, value) in parameters{
        guard let value = value as? String else{return}
        urlComponents.queryItems?.append(URLQueryItem(name: key, value: value))
    }
    
    guard let queryedURL = urlComponents.url else{return}
    
    let request = URLRequest(url: queryedURL)
    
    fetchedDataByDataTask(from: request, completion: completion)
}

func fetchedDataByDataTask(from request: URLRequest, completion: @escaping (Data) -> Void){
    
    let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
        
        if error != nil{
            print(error as Any)
        }else{
            guard let data = data else{return}
            completion(data)
        }
    }
    task.resume()
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
