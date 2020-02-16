//
//  CityWeatherNetworkManager.swift
//  WeatherApplication
//
//  Created by Mikhail G. on 15.02.2020.
//  Copyright © 2020 mg. All rights reserved.
//

import Foundation
import AlamofireObjectMapper
import Alamofire

class CityWeatherNetworkManager: NSObject{
    func getWeather(city: String, completionHandler: @escaping (_ success: Bool, _ forecast: ForecastResponse?, _ error: String?) -> Void){
        let networkManager = NetworkManager.sharedInstance
        networkManager.getRequest(url: "forecast", parameters: ["q" : city]) { (request, errorMessage, errorCode) in
            if errorMessage != nil || errorCode != nil{
                completionHandler(false, nil, errorMessage)
                return
            }
            request.responseObject { (response: DataResponse<ForecastResponse>) in
                completionHandler(true, response.result.value, nil)
            }
        }
    }
}
