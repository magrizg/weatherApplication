//
//  CityWeatherDataBaseManager.swift
//  WeatherApplication
//
//  Created by Mikhail G. on 15.02.2020.
//  Copyright © 2020 mg. All rights reserved.
//

import Foundation

private let entityName = CDForecast.entity().name!

class CityWeatherDataBaseManager{
    private let databaseManager = DataBaseManager()
    
    func save(forecast: ForecastModel, completionHandler: @escaping () -> Void){
        databaseManager.performBackgroundTask {[weak self] (context) in
            if let databaseManager = self?.databaseManager{
                var object = databaseManager.fetchEntities(entityName: entityName, context: context, predicate: NSPredicate.init(format: "id == %i", forecast.id), sortDescriptors: nil).first
                if object == nil{
                    object = databaseManager.createModel(entityName: entityName, context: context)
                }
                let cdForecast: CDForecast! = (object as! CDForecast)
                cdForecast.name = forecast.name
                cdForecast.id = Int64(forecast.id)
                cdForecast.tempToday = Int16(forecast.tempToday)
                cdForecast.tempMinToday = Int16(forecast.tempMinToday)
                cdForecast.tempMaxToday = Int16(forecast.tempMaxToday)
                cdForecast.pressureToday = Int16(forecast.pressureToday)
                
                cdForecast.tempNext1Day = Int16(forecast.tempNext1Day)
                cdForecast.tempNext2Day = Int16(forecast.tempNext2Day)
                cdForecast.tempNext3Day = Int16(forecast.tempNext3Day)
                
                databaseManager.saveContext(context: context)
            }
            DispatchQueue.main.async { completionHandler() }
        }
    }
    
    func remove(forecast: ForecastModel, completionHandler: (() -> Void)?){
        databaseManager.performBackgroundTask {[weak self] (context) in
            if let databaseManager = self?.databaseManager{
                if let object = databaseManager.fetchEntities(entityName: entityName, context: context, predicate: NSPredicate.init(format: "id == %i", forecast.id), sortDescriptors: nil).first{
                    context.delete(object)
                    databaseManager.saveContext(context: context)
                }
            }
            DispatchQueue.main.async { completionHandler?() }
        }
    }
    
    func getAllSavedModels() -> [ForecastModel]{
        let cdObjects: [CDForecast] = databaseManager.fetchEntities(entityName: entityName, context: databaseManager.viewContext(), predicate: nil, sortDescriptors: [NSSortDescriptor.init(key: "name", ascending: true)]) as! [CDForecast]
        var models = [ForecastModel]()
        for cdObject in cdObjects{
            models.append(ForecastModel.init(cdForecast: cdObject))
        }
        return models
    }
}
