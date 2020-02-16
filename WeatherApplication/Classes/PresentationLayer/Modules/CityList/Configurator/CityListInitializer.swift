//
//  CityListInitializer.swift
//  WeatherApplication
//
//  Created by Mikhail G. on 13/02/2020.
//  Copyright © 2020 mg. All rights reserved.
//

import UIKit

class CityListModuleInitializer: NSObject {

    //Connect with object on storyboard
    @IBOutlet weak var citylistViewController: CityListViewController!

    override func awakeFromNib() {

        let configurator = CityListModuleConfigurator()
        configurator.configureModuleForViewInput(viewInput: citylistViewController)
    }

}
