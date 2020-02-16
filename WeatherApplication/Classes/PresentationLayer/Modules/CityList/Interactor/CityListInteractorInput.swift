//
//  CityListInteractorInput.swift
//  WeatherApplication
//
//  Created by Mikhail G. on 13/02/2020.
//  Copyright © 2020 mg. All rights reserved.
//

import Foundation

protocol CityListInteractorInput {
    func searchCity(name: String)
    func getForecastsAndUpdate()
}
