//
//  CityListRouter.swift
//  WeatherApplication
//
//  Created by Mikhail G. on 13/02/2020.
//  Copyright © 2020 mg. All rights reserved.
//

class CityListRouter: RouterBase, CityListRouterInput {
    private static let kFromCityListToCityDescription = "FromCityListToCityDescription"
    
    func openCityDescription(forecastModel: ForecastModel){
        perform(segueIdentifier: CityListRouter.kFromCityListToCityDescription) { (module) in
            let cityDescriptionModule = module as! CityDescriptionModuleInput
            cityDescriptionModule.configureModule(forecastModel: forecastModel)
        }
    }
}
