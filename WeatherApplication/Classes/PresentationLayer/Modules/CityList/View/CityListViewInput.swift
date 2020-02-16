//
//  CityListViewInput.swift
//  WeatherApplication
//
//  Created by Mikhail G. on 13/02/2020.
//  Copyright © 2020 mg. All rights reserved.
//

protocol CityListViewInput: class {
    func set(viewModels: [TDMBaseCellViewModel])
    func changeButton(enabled: Bool)
    func showError(error: String)
}
