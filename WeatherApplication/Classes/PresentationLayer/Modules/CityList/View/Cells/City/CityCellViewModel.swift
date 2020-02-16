//
//  CityCellViewModel.swift
//  WeatherApplication
//
//  Created by Mikhail G. on 13.02.2020.
//  Copyright © 2020 mg. All rights reserved.
//

import Foundation

class CityCellViewModel: TwoLabelsCellViewModel {
    var forecast: ForecastModel!
    
    convenience init(forecast: ForecastModel, didSelect: @escaping TDMDidSelectCell) {
        self.init()
        self.forecast = forecast
        self.didSelect = didSelect
    }
    
    override func leftText() -> String?{
        return forecast.name
    }
    
    override func rightText() -> String?{
        return String.string(temperature: forecast.tempToday)
    }
}
