//
//  TwoLabelsCellViewModel.swift
//  WeatherApplication
//
//  Created by Mikhail G. on 14.02.2020.
//  Copyright © 2020 mg. All rights reserved.
//

import Foundation

class TwoLabelsCellViewModel: TDMBaseCellViewModel {
    override init() {
        super.init()
        cellClass = TwoLabelsCell.self
        heightCell = 44
    }
    
    func leftText() -> String?{
        return nil
    }
    
    func rightText() -> String?{
        return nil
    }
    
    func selectionActive() -> Bool{
        return didSelect != nil
    }
}
