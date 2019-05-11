//
//  DataParser.swift
//  AQI
//
//  Created by sean on 2019/5/11.
//  Copyright © 2019 sean. All rights reserved.
//

import Foundation

func dataToJsonArray(data: Data?) -> [Dictionary<String,Any>] {
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

func dataToString(data: Data?) -> String {
    if data != nil{
        return String(data: data!, encoding: .utf8) ?? ""
    }else{
        return ""
    }
    
}
