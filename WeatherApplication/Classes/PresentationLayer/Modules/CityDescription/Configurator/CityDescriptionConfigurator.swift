//
//  CityDescriptionConfigurator.swift
//  WeatherApplication
//
//  Created by Mikhail G. on 14/02/2020.
//  Copyright © 2020 mg. All rights reserved.
//

import UIKit

class CityDescriptionModuleConfigurator {

    func configureModuleForViewInput<UIViewController>(viewInput: UIViewController) {

        if let viewController = viewInput as? CityDescriptionViewController {
            configure(viewController: viewController)
        }
    }

    private func configure(viewController: CityDescriptionViewController) {

        let router = CityDescriptionRouter()
        router.transitionHandler = viewController

        let presenter = CityDescriptionPresenter()
        presenter.view = viewController
        presenter.router = router

        let interactor = CityDescriptionInteractor()
        interactor.output = presenter

        presenter.interactor = interactor
        viewController.output = presenter
    }

}
