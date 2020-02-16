//
//  TDMBaseCell.swift
//
//  Created by Mikhail Garbuz on 17.10.17.
//  Copyright © 2017 mg. All rights reserved.
//

import UIKit

class TDMBaseCell: UITableViewCell{
    var viewModel: TDMBaseCellViewModel?{
        willSet{
            if let viewModel = viewModel{
                if let cell = viewModel.cell{
                    if cell == self{
                        viewModel.cell = nil
                    }
                }
            }
        }
        didSet{
            viewModelChanged()
        }
    }
    
    func viewModelChanged(){
        viewModel?.cell = self
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
