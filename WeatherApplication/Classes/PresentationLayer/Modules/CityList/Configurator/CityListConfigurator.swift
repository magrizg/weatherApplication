//
//  CityListConfigurator.swift
//  WeatherApplication
//
//  Created by Mikhail G. on 13/02/2020.
//  Copyright © 2020 mg. All rights reserved.
//

import UIKit

class CityListModuleConfigurator {

    func configureModuleForViewInput<UIViewController>(viewInput: UIViewController) {

        if let viewController = viewInput as? CityListViewController {
            configure(viewController: viewController)
        }
    }

    private func configure(viewController: CityListViewController) {

        let router = CityListRouter()
        router.transitionHandler = viewController

        let presenter = CityListPresenter()
        presenter.view = viewController
        presenter.router = router

        let interactor = CityListInteractor()
        interactor.output = presenter

        presenter.interactor = interactor
        viewController.output = presenter
    }

}
