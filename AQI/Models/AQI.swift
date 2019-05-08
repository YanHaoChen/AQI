//
//  AQI.swift
//  AQI
//
//  Created by sean on 2019/5/8.
//  Copyright © 2019 sean. All rights reserved.
//

import RealmSwift

class AQIData: Object {
    @objc dynamic var site = ""
    @objc dynamic var aqi = 0.0
    @objc dynamic var status = ""
}
