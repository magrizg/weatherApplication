//
//  WeatherResponse.swift
//  WeatherApplication
//
//  Created by Mikhail G. on 15.02.2020.
//  Copyright © 2020 mg. All rights reserved.
//

import Foundation
import ObjectMapper

class MainResponse: Mappable{
    var temp: Float?
    var pressure: Int?
    var tempMax: Float?
    var tempMin: Float?

    func mapping(map: Map) {
        temp <- map["temp"]
        pressure <- map["pressure"]
        tempMax <- map["temp_max"]
        tempMin <- map["temp_min"]
    }
    
    required convenience init?(map: Map) {
        self.init()
    }
}

class WeatherResponse: Mappable{
    var main: MainResponse?
    var timestamp: Int?
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        main <- map["main"]
        timestamp <- map["dt"]
    }
}

class CityResponse: Mappable{
    var name: String?
    var country: String?
    var id: Int?
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        name <- map["name"]
        country <- map["country"]
        id <- map["id"]
    }
}

class ForecastResponse: Mappable{
    var list: [WeatherResponse]?
    var city: CityResponse?
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        list <- map["list"]
        city <- map["city"]
    }
}

