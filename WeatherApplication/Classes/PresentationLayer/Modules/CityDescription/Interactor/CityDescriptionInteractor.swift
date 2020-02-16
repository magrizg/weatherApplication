//
//  CityDescriptionInteractor.swift
//  WeatherApplication
//
//  Created by Mikhail G. on 14/02/2020.
//  Copyright © 2020 mg. All rights reserved.
//

class CityDescriptionInteractor: CityDescriptionInteractorInput {

    weak var output: CityDescriptionInteractorOutput!
    private let cityWeatherManager = CityWeatherManager()

    func remove(forecast: ForecastModel){
        cityWeatherManager.remove(forecast: forecast) {[weak self] in
            self?.output.removeCompleted()
        }
    }
}
