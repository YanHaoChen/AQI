//
//  NetworkManager.swift
//  AQI
//
//  Created by sean on 2019/5/8.
//  Copyright © 2019 sean. All rights reserved.
//

import Foundation
import Alamofire

let AQITop3: String = "https://opendata.epa.gov.tw/webapi/Data/REWIQA/?$orderby=SiteName&$skip=0&$top=3&format=json"

let DailyQuote: String = "https://tw.appledaily.com/index/dailyquote/"


func getAQIFromAPI(complete: @escaping (Array<Dictionary<String,String>>) -> ()){
    
    Alamofire.request(AQITop3)
        .responseJSON { response in
            // check for errors
            guard response.result.error == nil else {
                print("error calling GET")
                print(response.result.error!)
                return
            }
            
            guard let json = response.result.value as? Array<Dictionary<String,String>> else {
                print("didn't get objects")
                if let error = response.result.error {
                    print("Error: \(error)")
                }
                return
            }
            complete(json)
    }
}

func getDailyQuote(complete: @escaping (String) -> ()){
    
    Alamofire.request(DailyQuote)
        .responseString { response in
            // check for errors
            complete(response.result.value ?? "Can't find.")
    }
    
    
}




