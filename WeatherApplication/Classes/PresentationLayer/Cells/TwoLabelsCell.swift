//
//  TwoLabelsCell.swift
//  WeatherApplication
//
//  Created by Mikhail G. on 13.02.2020.
//  Copyright © 2020 mg. All rights reserved.
//

import UIKit
import SnapKit

class TwoLabelsCell: TDMBaseCell{
    private let labelLeft = UILabel()
    private let labelRight = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        let indent = 10
        
        contentView.addSubview(labelLeft)
        labelLeft.snp.makeConstraints { v in
            v.centerY.equalToSuperview()
            v.leading.equalToSuperview().offset(indent)
        }
        
        contentView.addSubview(labelRight)
        labelRight.snp.makeConstraints { v in
            v.centerY.equalToSuperview()
            v.leading.greaterThanOrEqualTo(labelLeft.snp.trailing).offset(indent)
            v.trailing.equalToSuperview().offset(-indent)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewModelChanged() {
        super.viewModelChanged()
        
        let viewModel = self.viewModel as! TwoLabelsCellViewModel
        
        labelLeft.text = viewModel.leftText()
        labelRight.text = viewModel.rightText()
        
        selectionStyle = viewModel.selectionActive() ? .default : .none
    }
}

