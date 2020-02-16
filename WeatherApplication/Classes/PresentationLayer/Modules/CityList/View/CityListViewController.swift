//
//  CityListViewController.swift
//  WeatherApplication
//
//  Created by Mikhail G. on 13/02/2020.
//  Copyright © 2020 mg. All rights reserved.
//

import UIKit

class CityListViewController: UIViewController, CityListViewInput {

    var output: CityListViewOutput!
    
    private lazy var textField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .lightGray
        textField.layer.cornerRadius = 4
        textField.placeholder = "City"
        textField.delegate = self
        return textField
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        return tableView
    }()
    
    private lazy var buttonAdd: UIButton = {
        let button = UIButton()
        button.setTitleColor(.blue, for: .normal)
        button.setTitleColor(.gray, for: .disabled)
        button.setTitleColor(.gray, for: .highlighted)
        button.setTitle("Add", for: .normal)
        button.addTarget(self, action: #selector(CityListViewController.pressButton), for: .touchUpInside)
        button.isEnabled = false
        return button
    }()
    
    private lazy var tableManager: TableDataManager = {
        let tableManager = TableDataManager()
        tableManager.tableView = tableView
        return tableManager
    }()

    // MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let indent = 10
        
        view.addSubview(textField)
        textField.snp.makeConstraints { v in
            v.top.equalTo(view.safeAreaLayoutGuide).offset(indent)
            v.leading.equalToSuperview().offset(indent)
            v.height.equalTo(40)
        }
        
        view.addSubview(buttonAdd)
        buttonAdd.snp.makeConstraints { v in
            v.centerY.equalTo(textField)
            v.leading.equalTo(textField.snp.trailing).offset(indent)
            v.trailing.equalToSuperview().offset(-indent)
        }
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints { v in
            v.top.equalTo(textField.snp.bottom).offset(indent)
            v.leading.equalToSuperview()
            v.trailing.equalToSuperview()
            v.bottom.equalToSuperview()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        output.viewWillAppear()
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(CityListViewController.onKeyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(CityListViewController.onKeyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        textField.resignFirstResponder()
        let notificationCenter = NotificationCenter.default
        notificationCenter.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        notificationCenter.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    //MARK: CityListViewInput
    func set(viewModels: [TDMBaseCellViewModel]){
        tableManager.arrayViewModels = viewModels
        tableView.reloadData()
    }
    
    func changeButton(enabled: Bool){
        buttonAdd.isEnabled = enabled
    }
    
    func showError(error: String){
        let alertController = UIAlertController(title: "Error", message: error, preferredStyle: .alert)
        alertController.addAction(UIAlertAction.init(title: "Ok", style: .cancel, handler: nil))
        present(alertController, animated: true, completion: nil)
    }
    
    //MARK: Actions
    @objc private func pressButton(){
        output.buttonPressed()
    }
    
    @objc private func onKeyboardWillShow(_ notification: NSNotification) {
        if let userInfo = notification.userInfo,
            let keyboardFrameEnd = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue{
            tableView.contentInset = UIEdgeInsets.init(top: 0, left: 0, bottom: keyboardFrameEnd.size.height, right: 0)
        }
    }
    
    @objc private func onKeyboardWillHide() {
        tableView.contentInset = UIEdgeInsets.zero
    }
}

extension CityListViewController: UITextFieldDelegate{
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let text = textField.text, let textRange = Range(range, in: text) {
            let updatedText = text.replacingCharacters(in: textRange,
                                                       with: string)
            output.change(cityName: updatedText)
        }
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
