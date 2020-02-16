//
//  CityDescriptionCellViewModel.swift
//  WeatherApplication
//
//  Created by Mikhail G. on 14.02.2020.
//  Copyright © 2020 mg. All rights reserved.
//

import Foundation

class CityDescriptionCellViewModel: TwoLabelsCellViewModel {
    private var leftString: String?
    private var rightString: String?
    
    convenience init(leftString: String?, rightString: String?) {
        self.init()
        self.leftString = leftString
        self.rightString = rightString
    }
    
    override func leftText() -> String?{
        return leftString
    }
    
    override func rightText() -> String?{
        return rightString
    }
}
