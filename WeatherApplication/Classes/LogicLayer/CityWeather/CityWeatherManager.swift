//
//  CityWeatherManager.swift
//  WeatherApplication
//
//  Created by Mikhail G. on 14.02.2020.
//  Copyright © 2020 mg. All rights reserved.
//

import Foundation

protocol CityWeatherManagerDelegate: class{
    func updated(forecasts: [ForecastModel])
    func errorLoad(message: String)
}

class CityWeatherManager{
    private let networkManager = CityWeatherNetworkManager()
    private let databaseManager = CityWeatherDataBaseManager()
    weak var delegate: CityWeatherManagerDelegate?
    
    func searchCity(name: String){
        loadCity(name: name, showError: true, completionHandler: nil)
    }
    
    func getForecastsAndUpdate(){
        let forecasts = databaseManager.getAllSavedModels()
        delegate?.updated(forecasts: forecasts)
        updateForecasts(forecasts: forecasts)
        if forecasts.count == 0{
            addDefaultObjects()
        }
    }
    
    func remove(forecast: ForecastModel, completionHandler: (() -> Void)?){
        databaseManager.remove(forecast: forecast, completionHandler: completionHandler)
    }
    
    private func addDefaultObjects(){
        var forecasts = [ForecastModel]()
        forecasts.append(ForecastModel.init(name: "Bangkok"))
        forecasts.append(ForecastModel.init(name: "Moscow"))
        updateForecasts(forecasts: forecasts)
    }

    private func loadCity(name: String, showError: Bool, completionHandler: (() -> Void)?){
        networkManager.getWeather(city: name) {[weak self] (success, forecast, error) in
            if let forecast = forecast{
                self?.saveWeather(forecast: forecast)
            }
            if let error = error, showError{
                self?.delegate?.errorLoad(message: error)
            }
            completionHandler?()
        }
    }
    
    private func saveWeather(forecast: ForecastResponse){
        let model = ForecastModel.init(response: forecast)
        databaseManager.save(forecast: model) {[weak self] in
            self?.getForecastsFromDB()
        }
    }
    
    private func getForecastsFromDB(){
        delegate?.updated(forecasts: databaseManager.getAllSavedModels())
    }
    
    private func updateForecasts(forecasts: [ForecastModel]){
        var mForecasts = forecasts
        guard let forecast = mForecasts.first else {
            getForecastsFromDB()
            return
        }
        mForecasts.removeFirst()
        loadCity(name: forecast.name, showError: false) {[weak self] in
            self?.updateForecasts(forecasts: mForecasts)
        }
    }
}
