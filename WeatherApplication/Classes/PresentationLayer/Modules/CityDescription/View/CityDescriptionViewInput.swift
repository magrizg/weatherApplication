//
//  CityDescriptionViewInput.swift
//  WeatherApplication
//
//  Created by Mikhail G. on 14/02/2020.
//  Copyright © 2020 mg. All rights reserved.
//

protocol CityDescriptionViewInput: class {
    func setTitle(name: String?)
    func set(viewModels: [TDMBaseCellViewModel])
    func showAlertRemove()
}
