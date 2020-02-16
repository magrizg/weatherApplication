//
//  TDMBaseCellViewModel.swift
//
//  Created by Mikhail Garbuz on 17.10.17.
//  Copyright © 2017 mg. All rights reserved.
//

import UIKit

typealias TDMDidSelectCell =  (TDMBaseCellViewModel) -> Void

class TDMBaseCellViewModel: NSObject{
    weak var tableManager: TableDataManager?
    var cellIdentifier: String?
    var cellClass: TDMBaseCell.Type?{
        didSet{
            if let cellClass = cellClass{
                self.cellIdentifier = NSStringFromClass(cellClass)
            }else{
                self.cellIdentifier = nil
            }
        }
    }
    var heightCell: Float = 0
    var didSelect: TDMDidSelectCell?
    weak var cell: TDMBaseCell?
}
