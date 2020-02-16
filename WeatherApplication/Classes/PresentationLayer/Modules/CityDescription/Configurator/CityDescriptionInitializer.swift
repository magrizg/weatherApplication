//
//  CityDescriptionInitializer.swift
//  WeatherApplication
//
//  Created by Mikhail G. on 14/02/2020.
//  Copyright © 2020 mg. All rights reserved.
//

import UIKit

class CityDescriptionModuleInitializer: NSObject {

    //Connect with object on storyboard
    @IBOutlet weak var citydescriptionViewController: CityDescriptionViewController!

    override func awakeFromNib() {

        let configurator = CityDescriptionModuleConfigurator()
        configurator.configureModuleForViewInput(viewInput: citydescriptionViewController)
    }

}
