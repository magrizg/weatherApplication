//
//  CityListInteractorOutput.swift
//  WeatherApplication
//
//  Created by Mikhail G. on 13/02/2020.
//  Copyright © 2020 mg. All rights reserved.
//

import Foundation

protocol CityListInteractorOutput: class {
    func updated(forecasts: [ForecastModel])
    func errorLoad(message: String)
}
