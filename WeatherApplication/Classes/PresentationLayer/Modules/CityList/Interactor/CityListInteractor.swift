//
//  CityListInteractor.swift
//  WeatherApplication
//
//  Created by Mikhail G. on 13/02/2020.
//  Copyright © 2020 mg. All rights reserved.
//

class CityListInteractor: CityListInteractorInput{

    weak var output: CityListInteractorOutput!
    
    private lazy var cityWeatherManager: CityWeatherManager = {
        let manager = CityWeatherManager()
        manager.delegate = self
        return manager
    }()

    func searchCity(name: String){
        cityWeatherManager.searchCity(name: name)
    }
    
    func getForecastsAndUpdate(){
        cityWeatherManager.getForecastsAndUpdate()
    }
}

extension CityListInteractor: CityWeatherManagerDelegate{
    func errorLoad(message: String) {
        output.errorLoad(message: message)
    }
    
    func updated(forecasts: [ForecastModel]) {
        output.updated(forecasts: forecasts)
    }
}
