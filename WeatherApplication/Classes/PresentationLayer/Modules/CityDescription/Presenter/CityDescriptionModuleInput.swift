//
//  CityDescriptionModuleInput.swift
//  WeatherApplication
//
//  Created by Mikhail G. on 14/02/2020.
//  Copyright © 2020 mg. All rights reserved.
//

protocol CityDescriptionModuleInput: class {
    func configureModule(forecastModel: ForecastModel)
}
