//
//  String+temp.swift
//  WeatherApplication
//
//  Created by Mikhail G. on 16.02.2020.
//  Copyright © 2020 mg. All rights reserved.
//

import Foundation

extension String{
    static func string(temperature: Int) -> String{
        var strTemp = "\(temperature)"
        if temperature > 0{
            strTemp = "+\(strTemp)"
        }
        return strTemp
    }
}
