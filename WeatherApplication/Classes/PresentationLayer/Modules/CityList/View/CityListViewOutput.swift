//
//  CityListViewOutput.swift
//  WeatherApplication
//
//  Created by Mikhail G. on 13/02/2020.
//  Copyright © 2020 mg. All rights reserved.
//

protocol CityListViewOutput {
    func viewWillAppear()
    func change(cityName: String?)
    func buttonPressed()
}
