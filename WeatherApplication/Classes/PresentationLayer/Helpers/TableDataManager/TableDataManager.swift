//
//  TableDataManager.swift
//
//  Created by Mikhail Garbuz on 17.10.17.
//  Copyright © 2017 mg. All rights reserved.
//

import UIKit

class TableDataManager: NSObject, UITableViewDataSource, UITableViewDelegate{
    var arrayViewModels: [TDMBaseCellViewModel]?{
        didSet{
            arrayViewModelsChanged()
        }
    }
    var tableView: UITableView?{
        didSet{
            if let tableView = tableView{
                tableView.delegate = self
                tableView.dataSource = self
            }
        }
    }
    
    private func arrayViewModelsChanged(){
        if let arrayViewModels = arrayViewModels{
            for viewModel in arrayViewModels{
                viewModel.tableManager = self
                if let cellClass = viewModel.cellClass, let cellIdentifier = viewModel.cellIdentifier{
                    self.tableView?.register(cellClass, forCellReuseIdentifier: cellIdentifier)
                }
            }
        }
    }
    
    //MARK: UITableViewDataSource

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        if let arrayViewModels = arrayViewModels{
            return arrayViewModels.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let viewModel = arrayViewModels![indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: viewModel.cellIdentifier!, for: indexPath) as! TDMBaseCell
        cell.viewModel = viewModel
        return cell
    }
    
    //MARK: UITableViewDelegate
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let viewModel = arrayViewModels![indexPath.row]
        return CGFloat(viewModel.heightCell);
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let viewModel = arrayViewModels![indexPath.row]
        if let didSelect = viewModel.didSelect{
            didSelect(viewModel)
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
