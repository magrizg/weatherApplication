//
//  ForecastModel.swift
//  WeatherApplication
//
//  Created by Mikhail G. on 15.02.2020.
//  Copyright © 2020 mg. All rights reserved.
//

import Foundation

class ForecastModel{
    var name = ""
    var tempToday = 0
    var id = 0
    var pressureToday = 0
    var tempMaxToday = 0
    var tempMinToday = 0
    
    var tempNext1Day = 0
    var tempNext2Day = 0
    var tempNext3Day = 0
    
    init(response: ForecastResponse){
        if let city = response.city{
            if let name = city.name{
                self.name = name
            }
            if let id = city.id{
                self.id = id
            }
        }
        if let main = response.list?.first?.main{
            if let temp = main.temp{
                tempToday = ForecastModel.celsiusTemperature(kelvinTemperature: Int(temp))
            }
            if let temp = main.tempMax{
                tempMaxToday = ForecastModel.celsiusTemperature(kelvinTemperature: Int(temp))
            }
            if let temp = main.tempMin{
                tempMinToday = ForecastModel.celsiusTemperature(kelvinTemperature: Int(temp))
            }
            if let pressure = main.pressure{
                pressureToday = pressure
            }
        }
        
        if let temp = response.list?[8].main?.temp{
            tempNext1Day = ForecastModel.celsiusTemperature(kelvinTemperature: Int(temp))
        }
        
        if let temp = response.list?[16].main?.temp{
            tempNext2Day = ForecastModel.celsiusTemperature(kelvinTemperature: Int(temp))
        }
        
        if let temp = response.list?[24].main?.temp{
            tempNext3Day = ForecastModel.celsiusTemperature(kelvinTemperature: Int(temp))
        }
    }
    
    init(cdForecast: CDForecast){
        if let name = cdForecast.name{
            self.name = name
        }
        id = Int(cdForecast.id)
        tempToday = Int(cdForecast.tempToday)
        tempMaxToday = Int(cdForecast.tempMaxToday)
        tempMinToday = Int(cdForecast.tempMinToday)
        pressureToday = Int(cdForecast.pressureToday)
        
        tempNext1Day = Int(cdForecast.tempNext1Day)
        tempNext2Day = Int(cdForecast.tempNext2Day)
        tempNext3Day = Int(cdForecast.tempNext3Day)
    }
    
    init(name: String){
        self.name = name
    }
    
    private static func celsiusTemperature(kelvinTemperature: Int) -> Int{
        return kelvinTemperature - 273
    }
}
