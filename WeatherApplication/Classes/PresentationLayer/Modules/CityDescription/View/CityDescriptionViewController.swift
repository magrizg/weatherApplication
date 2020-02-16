//
//  CityDescriptionViewController.swift
//  WeatherApplication
//
//  Created by Mikhail G. on 14/02/2020.
//  Copyright © 2020 mg. All rights reserved.
//

import UIKit

class CityDescriptionViewController: UIViewController, CityDescriptionViewInput {

    var output: CityDescriptionViewOutput!

    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        return tableView
    }()
    
    private lazy var tableManager: TableDataManager = {
        let tableManager = TableDataManager()
        tableManager.tableView = tableView
        return tableManager
    }()
    
    private lazy var buttonRemove: UIButton = {
        let button = UIButton()
        button.setTitleColor(.red, for: .normal)
        button.setTitleColor(.gray, for: .highlighted)
        button.setTitle("Remove", for: .normal)
        button.addTarget(self, action: #selector(CityDescriptionViewController.pressButton), for: .touchUpInside)
        return button
    }()
    
    // MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints { v in
            v.top.equalToSuperview()
            v.leading.equalToSuperview()
            v.trailing.equalToSuperview()
        }
        
        view.addSubview(buttonRemove)
        buttonRemove.snp.makeConstraints { v in
            v.top.equalTo(tableView.snp.bottom)
            v.centerX.equalToSuperview()
            v.bottom.equalToSuperview()
            v.height.equalTo(50)
        }
        
        output.viewIsReady()
    }
    
    //MARK: CityDescriptionViewInput
    func setTitle(name: String?){
        navigationItem.title = name
    }
    
    func set(viewModels: [TDMBaseCellViewModel]){
        tableManager.arrayViewModels = viewModels
        tableView.reloadData()
    }
    
    func showAlertRemove(){
        let alertController = UIAlertController(title: "Remove?", message: nil, preferredStyle: .alert)
        
        alertController.addAction(UIAlertAction.init(title: "Cancel", style: .cancel, handler: nil))
        alertController.addAction(UIAlertAction.init(title: "Remove", style: .destructive) {[weak self] (_) in
            self?.output.pressButtonRemoveConfirm()
        })

        present(alertController, animated: true, completion: nil)
    }
    
    //MARK: Actions
    @objc func pressButton(){
        output.pressButton()
    }
}
